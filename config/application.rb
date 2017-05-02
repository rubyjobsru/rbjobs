# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rbjobs
  class Application < Rails::Application
    config.i18n.default_locale = :en
    config.active_job.queue_adapter = :sucker_punch
  end
end
