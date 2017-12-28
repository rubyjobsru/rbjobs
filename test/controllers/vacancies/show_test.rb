# frozen_string_literal: true
require 'rails_helper'

module Test
  module Controllers
    module Vacancies
      class ShowTest < ActionDispatch::IntegrationTest
        fixtures(:vacancies)

        def test_approved
          get vacancy_url(vacancies(:approved))

          assert_response(:success)
        end

        def test_pending
          get vacancy_url(vacancies(:pending))

          assert_response(:not_found)
        end

        def test_pending_with_owner_token
          vacancy = vacancies(:pending)

          get vacancy_url(vacancy, token: vacancy.owner_token)

          assert_response(:not_found)
        end

        def test_pending_with_admin_token
          vacancy = vacancies(:pending)

          get vacancy_url(vacancy, token: vacancy.admin_token)

          assert_response(:success)
        end

        def test_pending_with_non_existing_token
          vacancy = vacancies(:pending)

          get vacancy_url(vacancy, token: 'foo-bar')

          assert_response(:not_found)
        end

        def test_archived
          get vacancy_url(vacancies(:archived))

          assert_response(:success)
        end
      end
    end
  end
end
