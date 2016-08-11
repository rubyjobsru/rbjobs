# frozen_string_literal: true
module Vacancies
  class Destroyer
    def initialize(vacancy)
      @vacancy = vacancy
    end

    def self.run(vacancy)
      new(vacancy).call
    end

    def call
      @vacancy.destroy
      @vacancy
    end
  end
end
