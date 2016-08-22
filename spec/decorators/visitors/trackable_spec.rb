# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visitors::Trackable do
  let(:visitor) { create(:visitor) }

  subject { described_class.new(visitor) }

  it 'decorates subject with #traits method' do
    expect(subject).to respond_to(:traits)
  end

  describe '#traits' do
    it 'builds a hash of traits' do
      traits = subject.traits

      expect(traits[:id]).to eql(visitor.id)
    end
  end
end
