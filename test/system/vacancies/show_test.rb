# frozen_string_literal: true
require 'application_system_test_case'

module Vacancies
  class ShowTest < ApplicationSystemTestCase
    fixtures(:vacancies)

    def test_visit_approved
      vacancy = vacancies(:approved)

      visit("/vacancies/#{vacancy.id}")

      assert_text(vacancy.title)
    end

    def test_visit_approved_with_admin_token
      vacancy = vacancies(:approved)

      visit("/vacancies/#{vacancy.id}?token=#{vacancy.admin_token}")

      assert_selector('a', text: I18n.t('vacancies.show.edit'))
    end

    def test_visit_approved_with_owner_token
      vacancy = vacancies(:approved)

      visit("/vacancies/#{vacancy.id}?token=#{vacancy.owner_token}")

      assert_selector('a', text: I18n.t('vacancies.show.edit'))
    end

    def test_visit_pending
      vacancy = vacancies(:pending)

      visit("/vacancies/#{vacancy.id}")

      assert_no_text(vacancy.title)
    end

    def test_visit_pending_with_admin_token
      vacancy = vacancies(:pending)

      visit("/vacancies/#{vacancy.id}?token=#{vacancy.admin_token}")

      assert_text(vacancy.title)
      assert_selector('a', text: I18n.t('vacancies.show.edit'))
    end

    def test_visit_pending_with_owner_token
      vacancy = vacancies(:pending)

      visit("/vacancies/#{vacancy.id}?token=#{vacancy.owner_token}")

      assert_no_text(vacancy.title)
      assert_no_selector('a', text: I18n.t('vacancies.show.edit'))
    end

    def test_visit_archived
      vacancy = vacancies(:archived)
      expiration_message = I18n.t(
        'vacancies.show.expiration_notice', expire_at: I18n.l(vacancy.expire_at)
      )

      visit("/vacancies/#{vacancy.id}")

      assert_text(vacancy.title)
      assert_text(expiration_message)
    end

    def test_visit_archived_with_admin_token
      vacancy = vacancies(:archived)

      visit("/vacancies/#{vacancy.id}?token=#{vacancy.admin_token}")

      assert_text(vacancy.title)
      assert_selector('a', text: I18n.t('vacancies.show.edit'))
    end

    # TODO: Archived vacancies must not be editable for owners.
    def test_visit_archived_with_owner_token
      vacancy = vacancies(:archived)

      visit("/vacancies/#{vacancy.id}?token=#{vacancy.owner_token}")

      assert_text(vacancy.title)
      assert_selector('a', text: I18n.t('vacancies.show.edit'))
    end
  end
end
