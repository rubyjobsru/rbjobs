require 'rails_helper'

RSpec.describe Vacancies::Destroyer do
  describe '.run' do
    let(:vacancy) { create(:vacancy) }

    subject { described_class }

    it 'deletes a vacancy' do
      result = subject.run(vacancy)

      expect(result).to be_destroyed
    end
  end

  describe '#call' do
    # This method implicitly covered by specs for Vacancies::Creator.run
  end
end
