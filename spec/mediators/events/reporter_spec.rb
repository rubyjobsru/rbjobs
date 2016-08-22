# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Reporter do
  describe '.run' do
    let(:event) do
      Events::Trackable.new(create(:event, vacancy: vacancy, visitor: visitor))
    end
    let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }
    let(:visitor) { create(:visitor) }

    subject { described_class }

    it 'sets a background job for publishing to Keen IO' do
      expect do
        subject.run(event)
      end.to have_enqueued_job(KeenJob)
    end
  end

  describe '#call' do
    # This method implicitly covered by specs for Vacancies::Creator.run
  end
end
