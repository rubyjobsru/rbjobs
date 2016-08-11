# frozen_string_literal: true
module VacanciesHelpers
  def persist_vacancy(vacancy)
    Vacancies::Persister.run(vacancy)
  end
end
