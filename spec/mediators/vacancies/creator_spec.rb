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

    # FIXME: Make example more pricise. The test should check that an email has
    #        been sent to the admin.
    it 'sends an email notification' do
      expect {
        subject.run(vacancy)
      }.to change {
        ActionMailer::Base.deliveries.size
      }.by(1)
    end

    context 'when a vacancy cannot be persisted' do
      before { allow(vacancy).to receive(:persisted?).and_return(false) }
      
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
