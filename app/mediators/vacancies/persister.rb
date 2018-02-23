# frozen_string_literal: true
require 'html_generator'
require 'securerandom'

module Vacancies
  class Persister
    def initialize(vacancy)
      @vacancy = vacancy
    end

    def self.run(vacancy)
      new(vacancy).call
    end

    def call
      ensure_tokens
      ensure_generated_html
      vacancy.save

      vacancy
    end

    private

    attr_reader :vacancy

    def ensure_tokens
      vacancy.owner_token ||= SecureRandom.urlsafe_base64(32)
      vacancy.admin_token ||= SecureRandom.urlsafe_base64(32)
    end

    def ensure_generated_html
      vacancy.description_html = HtmlGenerator.render(vacancy.description || '')
    end
  end
end
