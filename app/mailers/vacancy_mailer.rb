# frozen_string_literal: true
class VacancyMailer < ActionMailer::Base
  default from: 'notifier@rubyjobs.ru'

  def creation_notice(vacancy)
    @vacancy = vacancy
    subject = t('vacancy_mailer.creation_notice.subject', title: @vacancy.title)

    mail(to: ENV['SUPPORT_EMAIL'], subject: subject)
  end

  def approval_notice(vacancy)
    @vacancy = vacancy
    subject = t('vacancy_mailer.approval_notice.subject', title: @vacancy.title)

    mail(to: vacancy.email, subject: subject)
  end
end
