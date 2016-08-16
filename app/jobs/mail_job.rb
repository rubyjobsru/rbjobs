# frozen_string_literal: true
class MailJob < ApplicationJob
  queue_as :mail

  def perform(message, vacancy_id)
    ActiveRecord::Base.connection_pool.with_connection do
      vacancy = Vacancy.find(vacancy_id)
      VacancyMailer.send(message, vacancy).deliver
    end
  end
end
