# frozen_string_literal: true

require_relative 'helpers/fabrication_helpers'
require_relative 'helpers/vacancies_helpers'


RSpec.configure do |config|
  config.include FabricationHelpers
  config.include VacanciesHelpers
end
