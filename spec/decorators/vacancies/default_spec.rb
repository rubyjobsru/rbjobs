# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Vacancies::Default do
  let(:vacancy) { build(:vacancy) }

  subject { described_class.new(vacancy) }

  it 'decorates subject with #seo_title method' do
    expect(subject).to respond_to(:seo_title)
  end

  it 'decorates subject with #seo_description method' do
    expect(subject).to respond_to(:seo_description)
  end

  describe '#seo_title' do
    it 'builds a title using vacancy title' do
      expect(subject.seo_title).to include(subject.title)
    end

    context 'when company name has been supplied' do
      before { subject.company = 'Foo' }

      it 'builds a title using company name' do
        expect(subject.seo_title).to include(subject.company)
      end
    end

    context 'when company name is completely missing' do
      before { subject.company = nil }

      it 'does not mention a company name' do
        expect(subject.seo_title).not_to include(
          I18n.t('vacancies.seo_title.company', company: subject.company)
        )
      end
    end

    context 'when company name is just blank' do
      before { subject.company = '' }

      it 'does not mention a company name' do
        expect(subject.seo_title).not_to include(
          I18n.t('vacancies.seo_title.company', company: subject.company)
        )
      end
    end

    context 'when it is a remote position' do
      before { subject.remote_position = true }

      it 'mentions a remote option' do
        expect(subject.seo_title).to include(
          I18n.t('vacancies.seo_title.remote_position')
        )
      end
    end

    context 'when remote work is not possible' do
      before { subject.remote_position = false }

      it 'does not mention a remote option' do
        expect(subject.seo_title).not_to include(
          I18n.t('vacancies.seo_title.remote_position')
        )
      end
    end
  end

  describe '#seo_description' do
    it 'builds a description using vacancy title' do
      expect(subject.seo_description).to include(subject.title)
    end

    context 'when company name has been supplied' do
      before { subject.company = 'Foo' }

      it 'builds a description using company name' do
        expect(subject.seo_description).to include(subject.company)
      end
    end

    context 'when it is a remote position' do
      before { subject.remote_position = true }

      it 'mentions a remote option' do
        expect(subject.seo_description).to include(
          I18n.t('vacancies.seo_description.remote_position')
        )
      end
    end

    context 'when remote work is not possible' do
      before { subject.remote_position = false }

      it 'does not mention a remote option' do
        expect(subject.seo_description).not_to include(
          I18n.t('vacancies.seo_description.remote_position')
        )
      end
    end

    context 'when a minimum salary is supplied' do
      before { subject.salary_min = 100.0 }

      it 'mentions a rounded salary option in the description' do
        expect(subject.seo_description).to include('100')
      end
    end

    context 'when a maximum salary is supplied' do
      before { subject.salary_max = 200.0 }

      it 'mentions a rounded salary option in the description' do
        expect(subject.seo_description).to include('200')
      end
    end

    context 'when a salary currency is supplied' do
      before { subject.salary_currency = Vacancy::CURRENCY_EUR }

      it 'mentions a salary currency in the description' do
        expect(subject.seo_description).to include(
          I18n.t('vacancies.seo_description.salary.currency.EUR')
        )
      end
    end

    context 'when a salary unit is supplied' do
      before { subject.salary_unit = Vacancy::SALARY_UNIT_MONTH }

      it 'mentions a salary currency in the description' do
        expect(subject.seo_description).to include(
          I18n.t('vacancies.seo_description.salary.unit.month')
        )
      end
    end
  end

  describe '#salary' do
    it 'build a string of salary, currency and unit' do
      subject.salary_min = 100
      subject.salary_max = 200
      subject.salary_currency = Vacancy::CURRENCY_EUR
      subject.salary_unit = Vacancy::SALARY_UNIT_MONTH

      expect(subject.salary).to eql(
        '100-200' \
        ' ' + I18n.t('vacancies.seo_description.salary.currency.EUR') +
        ' ' + I18n.t('vacancies.seo_description.salary.unit.month')
      )
    end
  end

  describe '#salary_range' do
    it 'build a string of salary range' do
      subject.salary_min = 100
      subject.salary_max = 200

      expect(subject.salary_range).to eql('100-200')
    end

    context 'when only a minimum salary is supplied' do
      before do
        subject.salary_min = 100
        subject.salary_max = nil
      end

      it 'uses only minimum salary value' do
        expect(subject.salary_range).to eql('100')
      end
    end

    context 'when only a maximum salary is supplied' do
      before do
        subject.salary_min = nil
        subject.salary_max = 200
      end

      it 'uses only maximum salary value' do
        expect(subject.salary_range).to eql('200')
      end
    end

    context 'when no minimum nor maximum salary is supplied' do
      before do
        subject.salary_min = nil
        subject.salary_max = nil
      end

      it 'return an empty string' do
        expect(subject.salary_range).to eql('')
      end
    end
  end

  describe '#salary_measure' do
    it 'concatenates salary currency with its unit' do
      subject.salary_currency = Vacancy::CURRENCY_EUR
      subject.salary_unit = Vacancy::SALARY_UNIT_MONTH

      expect(subject.salary_measure).to eql(
        I18n.t('vacancies.seo_description.salary.currency.EUR') +
        ' ' + I18n.t('vacancies.seo_description.salary.unit.month')
      )
    end
  end
end
