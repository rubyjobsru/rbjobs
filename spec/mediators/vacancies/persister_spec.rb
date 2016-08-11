require 'rails_helper'

RSpec.describe Vacancies::Persister do
  describe '.run' do
    let(:vacancy) { build(:vacancy) }

    subject { described_class }

    it 'assigns access tokens' do
      result = subject.run(vacancy)

      expect(result.owner_token).not_to be_nil
      expect(result.admin_token).not_to be_nil
    end

    it 'assigns generated HTML' do
      result = subject.run(vacancy)

      expect(result.excerpt_html).not_to be_nil
      expect(result.description_html).not_to be_nil
    end

    it 'persists a given vacancy' do
      result = subject.run(vacancy)

      expect(result).to be_persisted
    end

    it 'returns a vacancy back' do
      result = subject.run(vacancy)

      expect(result).to be_a(Vacancy)
    end
  end

  describe '#call' do
    # This method implicitly covered by specs for Vacancies::Persister.run
  end
end
