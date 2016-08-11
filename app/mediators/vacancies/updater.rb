module Vacancies
  class Updater
    def initialize(vacancy)
      @vacancy = vacancy
    end

    def self.run(vacancy)
      new(vacancy).call
    end

    def call
      @vacancy = Vacancies::Persister.run(@vacancy)

      @vacancy
    end
  end
end
