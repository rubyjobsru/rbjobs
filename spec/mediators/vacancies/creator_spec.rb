# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Vacancies::Creator do
  describe '.run' do
    let(:vacancy) { build(:vacancy) }

    subject { described_class }

    it 'persists a given vacancy' do
      allow(Vacancies::Persister).to receive(:run).and_return(vacancy)
      subject.run(vacancy)

      expect(Vacancies::Persister).to have_received(:run)
    end

    it 'sets a background job for email delivery' do
      expect do
        subject.run(vacancy)
      end.to have_enqueued_job(MailJob)
    end

    it 'sends an email notification to the admin' do
      perform_enqueued_jobs do
        subject.run(vacancy)
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eql(ENV['SUPPORT_EMAIL'])
    end

    context 'when a vacancy cannot be persisted' do
      before { allow(vacancy).to receive(:persisted?).and_return(false) }

      it 'does not send any email notification' do
        expect do
          subject.run(vacancy)
        end.not_to have_enqueued_job(ActionMailer::DeliveryJob)
      end
    end
  end

  describe '#call' do
    # This method implicitly covered by specs for Vacancies::Creator.run
  end
end
