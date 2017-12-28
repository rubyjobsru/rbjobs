# frozen_string_literal: true
require 'application_system_test_case'

module Vacancies
  class CreateTest < ApplicationSystemTestCase
    def test_visit_new_vacancy_page
      visit('/vacancies/new')

      assert_text(I18n.t('vacancies.new.title'))
    end

    def test_post_new_vacancy
      visit('/vacancies/new')

      fill_in(I18n.t('activerecord.attributes.vacancy.title'),
              with: 'Ruby on Rails Developer')
      fill_in(I18n.t('activerecord.attributes.vacancy.description'),
              with: 'Long description')
      fill_in(I18n.t('activerecord.attributes.vacancy.location'),
              with: 'Berlin, Germany')
      fill_in(I18n.t('activerecord.attributes.vacancy.email'),
              with: 'john@example.com')
      choose('vacancy_expires_in_one_month')
      click_button(I18n.t('vacancies.form.create'))

      assert_equal('/', current_path)
      assert_text(I18n.t('vacancies.create.success'))
    end

    def test_post_new_vacancy_with_missing_information
      visit('/vacancies/new')

      fill_in(I18n.t('activerecord.attributes.vacancy.title'), with: '')
      click_button(I18n.t('vacancies.form.create'))

      assert_equal('/vacancies', current_path)
      assert_no_text(I18n.t('vacancies.create.success'))
    end
  end
end
