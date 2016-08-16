# frozen_string_literal: true
module Vacancies
  class Default < SimpleDelegator
    include ActiveSupport::NumberHelper

    delegate :t, :l, to: I18n

    def seo_title
      @seo_title ||= cleanup_and_join(
        [position_for_title,
         company_for_title,
         remote_for_title,
         expiration_for_title],
        '. '
      )
    end

    def seo_description
      @seo_description ||= cleanup_and_join(
        [company_for_description,
         remote_for_description,
         salary_for_description,
         expiration_for_description],
        '. '
      )
    end

    def salary
      @salary ||= cleanup_and_join(
        [salary_range,
         salary_measure],
        ' '
      )
    end

    def salary_range
      @salary_range ||= cleanup_and_join(
        [salary_number(salary_min),
         salary_number(salary_max)],
        '-'
      )
    end

    def salary_measure
      @salary_measure ||= cleanup_and_join(
        [salary_measure_currency,
         salary_measure_unit],
        ' '
      )
    end

    private

    def cleanup_and_join(parts, delimiter = '')
      parts.reject(&:blank?).join(delimiter)
    end

    def position_for_title
      t('vacancies.seo_title.position', position: title)
    end

    def company_for_title
      return if company.blank?
      t('vacancies.seo_title.company', company: company)
    end

    def remote_for_title
      return unless remote_position?
      t('vacancies.seo_title.remote_position')
    end

    def expiration_for_title
      if expired?
        t('vacancies.seo_title.expired')
      else
        t('vacancies.seo_title.expire_at', expire_at: l(expire_at))
      end
    end

    def company_for_description
      if company.present?
        t('vacancies.seo_description.company.present', position: title,
                                                       company: company)
      else
        t('vacancies.seo_description.company.blank', position: title)
      end
    end

    def remote_for_description
      return unless remote_position?
      t('vacancies.seo_description.remote_position')
    end

    def salary_for_description
      if salary.present?
        t('vacancies.seo_description.salary.present', salary: salary)
      else
        t('vacancies.seo_description.salary.blank')
      end
    end

    def expiration_for_description
      if expired?
        t('vacancies.seo_description.expired')
      else
        t('vacancies.seo_description.expire_at', expire_at: l(expire_at))
      end
    end

    def salary_number(number)
      number_to_rounded(number, precision: 2,
                                significant: true)
    end

    def salary_measure_currency
      return if salary_currency.blank?
      t("vacancies.seo_description.salary.currency.#{salary_currency}")
    end

    def salary_measure_unit
      return if salary_unit.blank?
      t("vacancies.seo_description.salary.unit.#{salary_unit}")
    end
  end
end
