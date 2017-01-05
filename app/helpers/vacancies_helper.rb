# frozen_string_literal: true
module VacanciesHelper
  def company_location_tag(vacancy)
    [
      vacancy.company,
      vacancy.location
    ].reject(&:blank?).join(' &mdash; ')
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

  def salary_to_human(vacancy)
    if salary_range?(vacancy)
      salary_range(vacancy)
    elsif minimun_salary?(vacancy)
      minimun_salary_with_prefix(vacancy)
    elsif maximum_salary?(vacancy)
      maximum_salary_with_prefix(vacancy)
    else
      t('vacancies.salary.not_defined')
    end
  end

  def salary_with_currency(vacancy)
    salary = salary_to_human(vacancy)

    if vacancy.salary_currency.present?
      salary << ' ' << t("vacancies.currencies.#{vacancy.salary_currency}")
    end

    salary
  end

  def salary_with_units(vacancy)
    salary = salary_with_currency(vacancy)

    if vacancy.salary_unit.present?
      salary << ' ' << t("vacancies.salary_units.#{vacancy.salary_unit}")
    end

    salary
  end

  private

  def salary_range?(vacancy)
    minimun_salary?(vacancy) && maximum_salary?(vacancy)
  end

  def minimun_salary?(vacancy)
    vacancy.salary_min && vacancy.salary_min.positive?
  end

  def maximum_salary?(vacancy)
    vacancy.salary_max && vacancy.salary_max.positive?
  end

  def salary_range(vacancy)
    range = [vacancy.salary_min, vacancy.salary_max].map do |number|
      number_with_precision(number, precision: 0)
    end
    range.join('&ndash;')
  end

  # rubocop:disable Metrics/LineLength
  def minimun_salary_with_prefix(vacancy)
    t('vacancies.salary.prefix.min') << ' ' << number_with_precision(vacancy.salary_min, precision: 0)
  end

  def maximum_salary_with_prefix(vacancy)
    t('vacancies.salary.prefix.max') << ' ' << number_with_precision(vacancy.salary_max, precision: 0)
  end
end
