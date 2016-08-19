# frozen_string_literal: true
require 'rails_helper'

RSpec.describe KeenJob, type: :job do
  describe '#perform' do
    let(:event_code) { 'foo' }
    let(:traits) { { foo: 'bar' } }

    it 'published an event to Keen IO' do
      allow(Keen).to receive(:publish)
      subject.perform(event_code, traits)

      expect(Keen).to have_received(:publish).with(event_code, traits)
    end
  end
end
