# frozen_string_literal: true

require 'rails_helper'

module Test
  module Controllers
    module Vacancies
      class CreateTest < ActionDispatch::IntegrationTest
        include ActiveJob::TestHelper

        def test_default
          assert_difference('Vacancy.count') do
            post vacancies_url, params: { vacancy: valid_attributes }
          end

          assert_response(:see_other)
          assert_redirected_to(root_url)
          assert_equal(I18n.t('vacancies.create.success'), flash[:success])
        end

        def test_with_missing_parameters
          assert_no_difference('Vacancy.count') do
            post vacancies_url, params: { vacancy: invalid_attributes }
          end

          assert_response(:unprocessable_entity)
        end

        def test_email_delivery
          assert_enqueued_with(job: MailJob) do
            post vacancies_url, params: { vacancy: valid_attributes }
          end
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
