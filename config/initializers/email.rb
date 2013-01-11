config = YAML.load_file(File.join(Rails.root, "config", "email.yml"))[Rails.env]

ActionMailer::Base.default_url_options = config['default_url_options'].symbolize_keys
ActionMailer::Base.delivery_method = config['delivery_method'].to_sym
if config['smtp_settings']
  ActionMailer::Base.smtp_settings = config['smtp_settings'].symbolize_keys
end
