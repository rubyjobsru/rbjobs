# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Page do
  let(:page_id) { Page.ids.first }

  describe '.find_by_id' do
    context 'when page exists' do
      it 'returns page with given id' do
        page = described_class.find_by_id(page_id)
        expect(page).not_to be_nil
        expect(page.id).to eql(page_id)
      end
    end

    context 'when page does not exists' do
      it 'returns nil' do
        page = described_class.find_by_id('foo')
        expect(page).to be_nil
      end
    end
  end

  describe '.exists?' do
    context 'when list of existing IDs includes given id' do
      it 'returns true' do
        expect(described_class.exists?(page_id)).to eql(true)
      end
    end

    context 'when list of existing IDs does not include given id' do
      it 'returns false' do
        expect(described_class.exists?('foo')).to eql(false)
      end
    end
  end
end
