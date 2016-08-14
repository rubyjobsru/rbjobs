# frozen_string_literal: true
module VacanciesHelper
  def meta_title(vacancy)
    parts = [t('vacancies.show.meta_title.title', title: vacancy.title)]

    if vacancy.company.present?
      parts << t('vacancies.show.meta_title.company', company: vacancy.company)
    end

    if vacancy.remote_position?
      parts << t('vacancies.show.meta_title.remote_position')
    end

    parts << t(
      'vacancies.show.meta_title.expire_at',
      expire_at: l(vacancy.expire_at)
    )

    parts.join('. ')
  end

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
