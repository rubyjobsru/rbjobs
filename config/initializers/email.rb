# frozen_string_literal: true

if ENV['APPLICATION_URL'].present?
  application_url = URI.parse(ENV['APPLICATION_URL'])

  ActionMailer::Base.default_url_options = {
    host: application_url.host
  }
end

if ENV['MAIL_SERVER_URL'].present?
  connection_url = URI.parse(ENV['MAIL_SERVER_URL'])

  ActionMailer::Base.delivery_method = connection_url.scheme.to_sym
  ActionMailer::Base.smtp_settings   = {
    address:   connection_url.host,
    port:      connection_url.port,
    user_name: connection_url.user,
    password:  connection_url.password
  }
end
