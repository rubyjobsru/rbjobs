class VacancyMailer < ActionMailer::Base
  default from: "notifier@rubyjobs.ru"

  def creation_notice(vacancy)
    @vacancy = vacancy
    mail(:to => ENV['SUPPORT_EMAIL'], :subject => t("vacancy_mailer.creation_notice.subject", :title => @vacancy.title))
  end

  def approval_notice(vacancy)
    @vacancy = vacancy
    mail(:to => vacancy.email, :subject => t("vacancy_mailer.approval_notice.subject", :title => @vacancy.title))
  end
end
