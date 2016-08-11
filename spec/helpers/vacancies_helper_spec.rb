# frozen_string_literal: true
require 'rails_helper'

RSpec.describe VacanciesHelper do
  let(:vacancy) { build(:vacancy) }

  subject { helper }

  describe '#company_location_tag' do
    context 'when company and location are presented' do
      before do
        vacancy.company = 'Monsters Inc.'
        vacancy.location = 'Monstropolis'
      end

      it 'concats company and location with dash' do
        expect(subject.company_location_tag(vacancy)).to eql(
          "#{vacancy.company} - #{vacancy.location}"
        )
      end
    end

    context 'when only company is blank' do
      before do
        vacancy.company = nil
        vacancy.location = 'Monstropolis'
      end

      it 'returns only location string' do
        expect(subject.company_location_tag(vacancy)).to eql(vacancy.location)
      end
    end

    context 'when only location is blank' do
      before do
        vacancy.company = 'Monsters Inc.'
        vacancy.location = nil
      end

      it 'returns only company string' do
        expect(subject.company_location_tag(vacancy)).to eql(vacancy.company)
      end
    end

    context 'when company and location are blank' do
      before do
        vacancy.company = nil
        vacancy.location = nil
      end

      it 'returns empty string' do
        expect(subject.company_location_tag(vacancy)).to be_blank
      end
    end
  end
end
