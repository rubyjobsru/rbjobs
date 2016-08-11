# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Vacancies::Updater do
  describe '.run' do
    let(:vacancy) { create(:vacancy) }

    subject { described_class }

    it 'persists a given vacancy' do
      allow(Vacancies::Persister).to receive(:run).and_return(vacancy)
      subject.run(vacancy)

      expect(Vacancies::Persister).to have_received(:run)
    end
  end

  describe '#call' do
    # This method implicitly covered by specs for Vacancies::Updater.run
  end
end
