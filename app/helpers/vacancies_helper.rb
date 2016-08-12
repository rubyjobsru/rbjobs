# frozen_string_literal: true
module VacanciesHelper
  def company_location_tag(vacancy)
    [vacancy.company, vacancy.location].reject(&:blank?).join(' - ')
  end

  def currency_options_for_select
    Vacancy::CURRENCIES.reduce([]) do |a, i|
      a << [t("vacancies.currencies.#{i}"), i]
    end
  end

  def salary_unit_options_for_select
    Vacancy::SALARY_UNITS.reduce([]) do |a, i|
      a << [t("vacancies.salary_units.#{i}"), i]
    end
  end

  def employment_type_options_for_select
    Vacancy::EMPLOYMENT_TYPES.reduce([]) do |a, i|
      a << [t("vacancies.employment_types.#{i}"), i]
    end
  end
end
