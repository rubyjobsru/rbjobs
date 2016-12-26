# frozen_string_literal: true

class EventsController < ApplicationController
  def create
    Events::Reporter.run(event)
  end

  private

  def event
    @event ||= build_decorated_event
  end

  def vacancy
    @vacancy ||= Vacancy.find(params[:vacancy_id])
  end

  def build_decorated_event
    event = Event.new do |instance|
      instance.code = params[:event_code]
      instance.vacancy = vacancy
      instance.visitor = current_visitor
    end

    Events::Trackable.new(event)
  end
end
