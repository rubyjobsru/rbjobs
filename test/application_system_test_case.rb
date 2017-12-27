# frozen_string_literal: true
require 'system_test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :remote,
                       screen_size: [1400, 1400],
                       options: {
                         url: ENV.fetch('SELENIUM_URL'),
                         desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
                       }

  def setup
    super
    host!(ENV.fetch('APP_URL'))
  end
end
