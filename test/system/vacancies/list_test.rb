# frozen_string_literal: true
require 'application_system_test_case'

module Vacancies
  class ListTest < ApplicationSystemTestCase
    fixtures(:vacancies)

    def test_only_approved_are_visible
      visit('/vacancies')


      assert_text(vacancies(:approved).title)
      assert_no_text(vacancies(:pending).title)
      assert_no_text(vacancies(:archived).title)
    end
  end
end
