require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rbjobs
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :sucker_punch
  end
end
