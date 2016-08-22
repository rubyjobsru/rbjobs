# frozen_string_literal: true

module Events
  class Reporter
    def initialize(event)
      @event = event
    end

    def self.run(*args)
      new(*args).call
    end

    def call
      KeenJob.perform_later(event.code, event.traits)
    end

    private

    attr_reader :event
  end
end
