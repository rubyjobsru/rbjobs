# frozen_string_literal: true
require 'application_system_test_case'

module Pages
  class ShowTest < ApplicationSystemTestCase
    def test_visit_about
      visit('/pages/about')

      assert_text(I18n.t('pages.show.about.title'))
    end

    def test_visit_terms
      visit('/pages/terms')

      assert_text(I18n.t('pages.show.terms.title'))
    end

    def test_visit_contacts
      visit('/pages/contacts')

      assert_text(I18n.t('pages.show.contacts.title'))
    end
  end
end
