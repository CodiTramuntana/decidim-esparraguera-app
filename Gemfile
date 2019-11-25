# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION
DECIDIM_VERSION = { git: 'https://github.com/decidim/decidim.git', branch: '0.19-stable' }

gem "decidim", DECIDIM_VERSION
# A Decidim module to customize the localized terms in the system.
# Read more: https://github.com/mainio/decidim-module-term_customizer
gem "decidim-term_customizer", git: 'https://github.com/mainio/decidim-module-term_customizer'

gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"
gem 'figaro', '>= 1.1.1'

# Force gem version to fix:
# undefined method `polymorphic?' for ActiveRecord::Reflection::PolymorphicReflection
# See: https://github.com/activerecord-hackery/ransack/issues/1039
gem 'ransack', '2.1.1'

gem 'delayed_job_active_record'
gem "daemons"
gem 'whenever', require: false

group :development, :test do
  gem "byebug", platform: :mri
  gem "faker", "~> 1.8.4"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3.0"
  gem "listen", "~> 3.1.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end

group :production do
  gem "sentry-raven"
end
