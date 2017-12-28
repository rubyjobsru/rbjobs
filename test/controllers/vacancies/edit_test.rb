# frozen_string_literal: true
require 'rails_helper'

module Test
  module Controllers
    module Vacancies
      class EditTest < ActionDispatch::IntegrationTest
        fixtures(:vacancies)

        # approved

        def test_approved
          get edit_vacancy_url(vacancies(:approved))

          assert_response(:not_found)
        end

        def test_approved_with_owner_token
          vacancy = vacancies(:approved)
          get edit_vacancy_url(vacancy, token: vacancy.owner_token)

          assert_response(:success)
        end

        def test_approved_with_admin_token
          vacancy = vacancies(:approved)
          get edit_vacancy_url(vacancy, token: vacancy.admin_token)

          assert_response(:success)
        end

        def test_approved_with_non_existing_token
          vacancy = vacancies(:approved)
          get edit_vacancy_url(vacancy, token: 'foo-bar')

          assert_response(:not_found)
        end

        # pending

        def test_pending
          get edit_vacancy_url(vacancies(:pending))

          assert_response(:not_found)
        end

        def test_pending_with_owner_token
          vacancy = vacancies(:pending)
          get edit_vacancy_url(vacancy, token: vacancy.owner_token)

          assert_response(:not_found)
        end

        def test_pending_with_admin_token
          vacancy = vacancies(:pending)
          get edit_vacancy_url(vacancy, token: vacancy.admin_token)

          assert_response(:success)
        end

        def test_pending_with_non_existing_token
          vacancy = vacancies(:pending)
          get edit_vacancy_url(vacancy, token: 'foo-bar')

          assert_response(:not_found)
        end

        # archived

        def test_archived
          get edit_vacancy_url(vacancies(:archived))

          assert_response(:not_found)
        end

        def test_archived_with_owner_token
          vacancy = vacancies(:archived)
          get edit_vacancy_url(vacancy, token: vacancy.owner_token)

          assert_response(:success)
        end

        def test_archived_with_admin_token
          vacancy = vacancies(:archived)
          get edit_vacancy_url(vacancy, token: vacancy.admin_token)

          assert_response(:success)
        end

        def test_archived_with_non_existing_token
          vacancy = vacancies(:archived)
          get edit_vacancy_url(vacancy, token: 'foo-bar')

          assert_response(:not_found)
        end
      end
    end
  end
end
