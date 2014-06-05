require "spec_helper"

describe VacancyMailer do
  let(:vacancy) do
    stub_model(Vacancy, {
      :title       => "Foo",
      :description => "Lorem ipsum",
      :company     => "Foo Inc.",
      :email       => "person@example.com",
      :expire_at   => 1.week.from_now.to_date
    })
  end

  describe "creation_notice" do
    before{ @email = VacancyMailer.creation_notice(vacancy).deliver }

    it "should put email into queue" do
      ActionMailer::Base.deliveries.should_not be_blank
    end
    it "should deliver message to support email" do
      @email.to.should include(ENV['SUPPORT_EMAIL'])
    end
  end

  describe "approval_notice" do
    before{ @email = VacancyMailer.approval_notice(vacancy).deliver }

    it "should put email into queue" do
      ActionMailer::Base.deliveries.should_not be_blank
    end
    it "should deliver message to vacancy's owner" do
      @email.to.should include(vacancy.email)
    end
  end
end
