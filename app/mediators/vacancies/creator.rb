# frozen_string_literal: true
module Vacancies
  class Creator
    def initialize(vacancy)
      @vacancy = vacancy
    end

    def self.run(vacancy)
      new(vacancy).call
    end

    def call
      @vacancy = Vacancies::Persister.run(@vacancy)
      notify if @vacancy.persisted?

      @vacancy
    end

    private

    def notify
      VacancyMailer.creation_notice(@vacancy).deliver_later
    end
  end
end
