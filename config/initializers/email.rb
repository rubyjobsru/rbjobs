# frozen_string_literal: true
ActionMailer::Base.default_url_options = {
  host: ENV['DEFAULT_URL_OPTIONS_HOST']
}
ActionMailer::Base.delivery_method = ENV['EMAIL_DELIVERY_METHOD'].to_sym
ActionMailer::Base.smtp_settings = {
  address: ENV['SMTP_ADDRESS'],
  port: ENV['SMTP_PORT'],
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD']
}
