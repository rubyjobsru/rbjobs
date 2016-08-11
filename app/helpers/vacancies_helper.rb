# frozen_string_literal: true
module VacanciesHelper
  def company_location_tag(vacancy)
    [vacancy.company, vacancy.location].reject(&:blank?).join(' - ')
  end
end
