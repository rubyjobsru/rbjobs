# frozen_string_literal: true
require 'application_system_test_case'

class PagesTest < ApplicationSystemTestCase
  def test_about_page
    visit('/pages/about')

    assert_text(I18n.t('pages.show.about.title'))
  end

  def test_terms_page
    visit('/pages/terms')

    assert_text(I18n.t('pages.show.terms.title'))
  end

  def test_contacts_page
    visit('/pages/contacts')

    assert_text(I18n.t('pages.show.contacts.title'))
  end
end
