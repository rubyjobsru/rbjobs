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
      vacancy.excerpt_html = HtmlGenerator.render(
        extract_excerpt(vacancy.description)
      )
      vacancy.description_html = HtmlGenerator.render(vacancy.description)
    end

    def extract_excerpt(text, divider = "\r\n\r\n")
      text.lines(divider)
          .to_a
          .each(&:strip!)
          .reject(&:blank?)
          .take(3)
          .join(divider)
    end
  end
end
