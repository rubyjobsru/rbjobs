# frozen_string_literal: true
require 'rails_helper'

module Test
  module Controllers
    module Vacancies
      class UpdateTest < ActionDispatch::IntegrationTest
        fixtures(:vacancies)

        # approved

        def test_approved
          put vacancy_url(vacancies(:approved)), params: { vacancy: valid_attributes }

          assert_response(:not_found)
        end

        def test_approved_with_owner_token
          vacancy = vacancies(:approved)
          put vacancy_url(vacancy, token: vacancy.owner_token),
              params: { vacancy: valid_attributes }

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.update.success'), flash[:success])
        end

        def test_approved_with_admin_token
          vacancy = vacancies(:approved)
          put vacancy_url(vacancy, token: vacancy.admin_token),
              params: { vacancy: valid_attributes }

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.update.success'), flash[:success])
        end

        def test_approved_with_non_existing_token
          vacancy = vacancies(:approved)
          put vacancy_url(vacancy, token: 'foo-bar'),
              params: { vacancy: valid_attributes }

          assert_response(:not_found)
        end

        # pending

        def test_pending
          put vacancy_url(vacancies(:pending)), params: { vacancy: valid_attributes }

          assert_response(:not_found)
        end

        def test_pending_with_owner_token
          vacancy = vacancies(:pending)
          put vacancy_url(vacancy, token: vacancy.owner_token),
              params: { vacancy: valid_attributes }

          assert_response(:not_found)
        end

        def test_pending_with_admin_token
          vacancy = vacancies(:pending)
          put vacancy_url(vacancy, token: vacancy.admin_token),
              params: { vacancy: valid_attributes }

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.update.success'), flash[:success])
        end

        def test_pending_with_non_existing_token
          vacancy = vacancies(:pending)
          put vacancy_url(vacancy, token: 'foo-bar'),
              params: { vacancy: valid_attributes }

          assert_response(:not_found)
        end

        # archived

        def test_archived
          put vacancy_url(vacancies(:archived)), params: { vacancy: valid_attributes }

          assert_response(:not_found)
        end

        def test_archived_with_owner_token
          vacancy = vacancies(:archived)
          put vacancy_url(vacancy, token: vacancy.owner_token),
              params: { vacancy: valid_attributes }

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.update.success'), flash[:success])
        end

        def test_archived_with_admin_token
          vacancy = vacancies(:archived)
          put vacancy_url(vacancy, token: vacancy.admin_token),
              params: { vacancy: valid_attributes }

          assert_response(:see_other)
          assert_redirected_to(vacancy_url(vacancy))
          assert_equal(I18n.t('vacancies.update.success'), flash[:success])
        end

        def test_archived_with_non_existing_token
          vacancy = vacancies(:archived)
          put vacancy_url(vacancy, token: 'foo-bar'),
              params: { vacancy: valid_attributes }

          assert_response(:not_found)
        end

        private

        def valid_attributes
          @valid_attributes ||= {
            title: 'Senior Engineer',
            description: 'Long description',
            location: 'Berlin, Germany',
            email: 'john@example.com',
            expire_at: 1.week.from_now
          }
        end

        def invalid_attributes
          @invalid_attributes ||= {
            title: 'Senior Engineer'
          }
        end
      end
    end
  end
end
