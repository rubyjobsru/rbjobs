# frozen_string_literal: true
require 'rails_helper'

module Test
  module Controllers
    module Vacancies
      class ApproveTest < ActionDispatch::IntegrationTest
        fixtures(:vacancies)

        # approved

        def test_approved
          put approve_vacancy_url(vacancies(:approved))

          assert_response(:not_found)
        end

        def test_approved_with_owner_token
          vacancy = vacancies(:approved)
          put approve_vacancy_url(vacancy, token: vacancy.owner_token)

          assert_response(:not_found)
        end

        def test_approved_with_admin_token
          vacancy = vacancies(:approved)
          put approve_vacancy_url(vacancy, token: vacancy.admin_token)

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.approve.success'), flash[:success])
        end

        def test_approved_with_non_existing_token
          vacancy = vacancies(:approved)
          put approve_vacancy_url(vacancy, token: 'foo-bar')

          assert_response(:not_found)
        end

        # approve pending

        def test_pending
          put approve_vacancy_url(vacancies(:pending))

          assert_response(:not_found)
        end

        def test_pending_with_owner_token
          vacancy = vacancies(:pending)
          put approve_vacancy_url(vacancy, token: vacancy.owner_token)

          assert_response(:not_found)
        end

        def test_pending_with_admin_token
          vacancy = vacancies(:pending)
          put approve_vacancy_url(vacancy, token: vacancy.admin_token)

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.approve.success'), flash[:success])
        end

        def test_pending_non_existing_token
          vacancy = vacancies(:pending)
          put approve_vacancy_url(vacancy, token: 'foo-bar')

          assert_response(:not_found)
        end

        # approve archived

        def test_archived
          put approve_vacancy_url(vacancies(:archived))

          assert_response(:not_found)
        end

        def test_archived_with_owner_token
          vacancy = vacancies(:archived)
          put approve_vacancy_url(vacancy, token: vacancy.owner_token)

          assert_response(:not_found)
        end

        def test_archived_with_admin_token
          vacancy = vacancies(:archived)
          put approve_vacancy_url(vacancy, token: vacancy.admin_token)

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.approve.success'), flash[:success])
        end

        def test_archived_with_non_existing_token
          vacancy = vacancies(:archived)
          put approve_vacancy_url(vacancy, token: 'foo-bar')

          assert_response(:not_found)
        end
      end
    end
  end
end
