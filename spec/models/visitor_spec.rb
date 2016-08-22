# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visitor do
  let(:store) { Hash.new }

  before { Visitor.store = store }

  describe '.find_or_create' do
    context 'when a visitor does not exist in the store' do
      it 'creates and persits a visitor' do
        result = described_class.find_or_create
        expect(result).to be_a(Visitor)
      end
    end

    context 'when a visitor exists already in the store' do
      let(:existing_id) { SecureRandom.uuid }

      before { store[Visitor::STORE_FIELD] = existing_id }

      it 'returns a visitor' do
        result = described_class.find_or_create
        expect(result.id).to eql(existing_id)
      end
    end
  end
end
