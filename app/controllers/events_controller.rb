# frozen_string_literal: true

class EventsController < ApplicationController
  def create
    Events::Reporter.run(event)
  end

  private

  def event
    @event ||= begin
      _event = Event.new do |event|
        event.code = params[:event_code]
        event.vacancy = vacancy
        event.visitor = current_visitor
      end

      Events::Trackable.new(_event)
    end
  end

  def vacancy
    @vacancy ||= Vacancy.find(params[:vacancy_id])
  end
end
