# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Vacancies::Approver do
  describe '.run' do
    let(:vacancy) { create(:vacancy) }

    subject { described_class }

    it 'sets an approval timestamp on a vacancy' do
      result = subject.run(vacancy)

      expect(result.approved_at).not_to be_nil
    end

    it 'sets a background job for email delivery' do
      expect do
        subject.run(vacancy)
      end.to have_enqueued_job(MailJob)
    end

    it 'sends an email notification to the owner' do
      perform_enqueued_jobs do
        subject.run(vacancy)
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eql(vacancy.email)
    end

    context 'when a vacancy cannot be approved' do
      before { allow(vacancy).to receive(:approved?).and_return(false) }

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
