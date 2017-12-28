# frozen_string_literal: true
require 'rails_helper'

module Test
  module Controllers
    module Vacancies
      class ListTest < ActionDispatch::IntegrationTest
        def test_default
          get vacancies_url

          assert_response(:success)
        end
      end
    end
  end
end
