# frozen_string_literal: true
class EventsController < ApplicationController
  def create
    Events::Creator.run(event_code, vacancy)
  end

  private

  def vacancy
    @vacancy ||= Vacancy.find(params[:vacancy_id])
  end

  def event_code
    @event_code ||= params[:event_code]
  end
end
