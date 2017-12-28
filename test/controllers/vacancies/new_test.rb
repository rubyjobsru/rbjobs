# frozen_string_literal: true
require 'rails_helper'

module Test
  module Controllers
    module Vacancies
      class NewTest < ActionDispatch::IntegrationTest
        def test_default
          get new_vacancy_url

          assert_response(:success)
        end
      end
    end
  end
end
