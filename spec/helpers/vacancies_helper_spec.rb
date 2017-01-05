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
          "#{vacancy.company} &mdash; #{vacancy.location}"
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

  describe '#salary_to_human' do
    before do
      vacancy.salary_min = 100
      vacancy.salary_max = 200
      vacancy.salary_currency = Vacancy::CURRENCY_EUR
    end

    it 'concatinates salary numbers using en dash' do
      expect(subject.salary_to_human(vacancy)).to eql('100&ndash;200')
    end

    context 'when minimum number is omitted' do
      before do
        vacancy.salary_min = nil
      end

      it 'uses only maximum number with prefix' do
        expect(subject.salary_to_human(vacancy)).to eql('до 200')
      end
    end

    context 'when maximum number is omitted' do
      before do
        vacancy.salary_max = nil
      end

      it 'uses only minimum number with prefix' do
        expect(subject.salary_to_human(vacancy)).to eql('от 100')
      end
    end

    context 'when salary range is not stated' do
      before do
        vacancy.salary_min = nil
        vacancy.salary_max = nil
      end

      it 'returns default "not defined" message' do
        expect(subject.salary_to_human(vacancy)).to eql(
          t('vacancies.salary.not_defined')
        )
      end
    end
  end

  describe '#salary_with_currency' do
    before do
      vacancy.salary_min = 100
      vacancy.salary_max = 200
      vacancy.salary_currency = Vacancy::CURRENCY_EUR
    end

    it 'concatinates salary human numbers with currency' do
      salary = subject.salary_to_human(vacancy)
      expect(subject.salary_with_currency(vacancy)).to eql("#{salary} евро")
    end

    context 'when currency is not stated' do
      before do
        vacancy.salary_currency = nil
      end

      it 'returns just salary numbers' do
        salary = subject.salary_to_human(vacancy)
        expect(subject.salary_with_currency(vacancy)).to eql(salary)
      end
    end

    context 'when currency is an empty string' do
      before do
        vacancy.salary_currency = ''
      end

      it 'returns just salary numbers' do
        salary = subject.salary_to_human(vacancy)
        expect(subject.salary_with_currency(vacancy)).to eql(salary)
      end
    end
  end

  describe '#salary_with_units' do
    before do
      vacancy.salary_min = 100
      vacancy.salary_max = 200
      vacancy.salary_currency = Vacancy::CURRENCY_EUR
      vacancy.salary_unit = Vacancy::SALARY_UNIT_HOUR
    end

    it 'concatinates salary line with units' do
      salary = subject.salary_with_currency(vacancy)
      expect(subject.salary_with_units(vacancy)).to eql("#{salary} в час")
    end

    context 'when units are not stated' do
      before do
        vacancy.salary_unit = nil
      end

      it 'returns just salary line' do
        salary = subject.salary_with_currency(vacancy)
        expect(subject.salary_with_units(vacancy)).to eql(salary)
      end
    end

    context 'when units are an empty string' do
      before do
        vacancy.salary_unit = ''
      end

      it 'returns just salary line' do
        salary = subject.salary_with_currency(vacancy)
        expect(subject.salary_with_units(vacancy)).to eql(salary)
      end
    end
  end
end
