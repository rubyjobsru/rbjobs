# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.3.1'

gem 'bugsnag'
gem 'figaro'
gem 'foreman', require: false
gem 'jquery-rails'
gem 'kaminari'
gem 'keen'
gem 'pg'
gem 'puma', require: false
gem 'rails'
gem 'redcarpet'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'sucker_punch'
gem 'therubyracer'
gem 'uglifier'

group :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'fabrication'
end

group :development do
  gem 'letter_opener'
  gem 'mina', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'faker'
end
