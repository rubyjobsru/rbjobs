# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Events::Creator do
  describe '.run' do
    let(:event_code) { 'foo' }
    let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }

    subject { described_class }

    it 'sets a background job for publishing to Keen IO' do
      expect do
        subject.run(event_code, vacancy)
      end.to have_enqueued_job(KeenJob)
    end
  end

  describe '#call' do
    # This method implicitly covered by specs for Vacancies::Creator.run
  end
end
