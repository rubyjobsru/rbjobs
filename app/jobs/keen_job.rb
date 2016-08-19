# frozen_string_literal: true
class KeenJob < ApplicationJob
  queue_as :keen

  def perform(event_code, traits)
    Keen.publish(event_code, traits)
  end
end
