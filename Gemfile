# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION
DECIDIM_VERSION= '0.13.1'

gem "rails", "5.2.0"

gem "decidim", DECIDIM_VERSION

gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"
gem 'figaro', '>= 1.1.1'

gem 'delayed_job_active_record'
gem "daemons"
gem 'whenever', require: false

group :development, :test do
  gem "byebug", platform: :mri
  # gem "faker", "~> 1.8.4"
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
