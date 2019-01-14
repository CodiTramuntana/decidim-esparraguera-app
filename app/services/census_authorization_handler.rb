# frozen_string_literal: true
require "digest/md5"

# Checks the authorization against the census for Sant Cugat.
#
# This class performs a check against the official census database in order
# to verify the citizen's residence.
class CensusAuthorizationHandler < Decidim::AuthorizationHandler
  include ActionView::Helpers::SanitizeHelper

  attribute :date_of_birth, Date
  attribute :document_number, String

  validates :date_of_birth, presence: true
  validates :document_number, format: { with: /\A[A-z0-9]*\z/ }, presence: true

  validate :over_16
  validate :check_response

  def self.from_params(params, additional_params = {})
    instance = super(params, additional_params)

    params_hash = hash_from(params)

    if params_hash["date_of_birth(1i)"]
      date = Date.civil(
        params["date_of_birth(1i)"].to_i,
        params["date_of_birth(2i)"].to_i,
        params["date_of_birth(3i)"].to_i
      )

      instance.date_of_birth = date
    end

    instance
  end

  # If you need to store any of the defined attributes in the authorization you
  # can do it here.
  #
  # You must return a Hash that will be serialized to the authorization when
  # it's created, and available though authorization.metadata
  def metadata
    super
  end

  def unique_id
    Digest::MD5.hexdigest(
      "#{document_number}-#{Rails.application.secrets.secret_key_base}"
    )
  end

  private

  # Internal: Checks for the response status. It is valid only when the `"res"` field
  # is `1`. All other values imply some different kind of errors, but in order to not
  # leak private data we will not care about them.
  #
  # Returns nothing.
  def check_response
    errors.add(:base, :invalid) unless response.present? && registered_in_town?
  end

  def registered_in_town?
    false unless response.xpath('//ciutadans//ciutada').first.present?
    response.xpath('//ciutadans//ciutada').first.content == "OK"
  end

  def sanitized_date_of_birth
    @sanitized_date_of_birth ||= date_of_birth.strftime("%d/%m/%Y")
  end

  def response
    return nil if date_of_birth.blank? || document_number.blank?
    return @response if defined?(@response)

    connection = Faraday.new Rails.application.secrets.dig(:census, :url), ssl: { verify: false }
    #connection.basic_auth(Rails.application.secrets.dig(:census, :auth_user), Rails.application.secrets.dig(:census, :auth_pass))

    response = connection.get do |request|
      request.params = request_params
    end

    @response ||= Nokogiri::XML(response.body).remove_namespaces!
  end

  def request_params
    {
      data: sanitized_date_of_birth,
      nif: document_number
    }
  end

  def over_16
    errors.add(:date_of_birth, I18n.t("census_authorization_handler.age_under_16")) unless age && age >= 16
  end

  def age
    return nil if date_of_birth.blank?

    now = Date.current
    extra_year = (now.month > date_of_birth.month) || (
      now.month == date_of_birth.month && now.day >= date_of_birth.day
    )

    now.year - date_of_birth.year - (extra_year ? 0 : 1)
  end
end
