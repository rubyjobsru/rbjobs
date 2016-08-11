require 'rails_helper'

RSpec.describe Vacancies::Approver do
  describe '.run' do
    let(:vacancy) { create(:vacancy) }

    subject { described_class }

    it 'sets an approval timestamp on a vacancy' do
      result = subject.run(vacancy)

      expect(result.approved_at).not_to be_nil
    end

    # FIXME: Make example more pricise. The test should check that an email has
    #        been sent to the owner.
    it 'sends an email notification' do
      expect {
        subject.run(vacancy)
      }.to change {
        ActionMailer::Base.deliveries.size
      }.by(1)
    end

    context 'when a vacancy cannot be approved' do
      before { allow(vacancy).to receive(:approved?).and_return(false) }

      it 'does not send any email notification' do
        expect {
          subject.run(vacancy)
        }.not_to change {
          ActionMailer::Base.deliveries.size
        }
      end
    end
  end

  describe '#call' do
    # This method implicitly covered by specs for Vacancies::Creator.run
  end
end
