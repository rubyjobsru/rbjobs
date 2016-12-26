# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vacancies::Trackable do
  include DateTimeHelpers

  let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }

  subject { described_class.new(vacancy) }

  it 'decorates subject with #traits method' do
    expect(subject).to respond_to(:traits)
  end

  describe '#traits' do
    it 'builds a hash of traits' do
      traits = subject.traits

      expect(traits[:id]).to eql(vacancy.id)
      expect(traits[:salary_min]).to eql(vacancy.salary_min)
      expect(traits[:salary_max]).to eql(vacancy.salary_max)
      expect(traits[:salary_currency]).to eql(vacancy.salary_currency)
      expect(traits[:salary_unit]).to eql(vacancy.salary_unit)
      expect(traits[:employment_type]).to eql(vacancy.employment_type)
      expect(traits[:remote_position]).to eql(vacancy.remote_position)
    end

    it 'represents a creation timestamp as a hash' do
      trait = subject.traits[:created_at]
      timestamp = vacancy.created_at.to_datetime

      expect(trait[:hour]).to eql(timestamp.hour)
      expect(trait[:minute]).to eql(timestamp.min)
      expect(trait[:day]).to eql(timestamp.mday)
      expect(trait[:week]).to eql(timestamp.cweek)
      expect(trait[:month]).to eql(timestamp.month)
      expect(trait[:quarter]).to eql(quarter_for(timestamp))
      expect(trait[:year]).to eql(timestamp.year)
      expect(trait[:day_of_week]).to eql(timestamp.wday)
      expect(trait[:day_of_year]).to eql(timestamp.yday)
      expect(trait[:iso8601]).to eql(timestamp.iso8601)
    end

    it 'represents a approval timestamp as a hash' do
      trait = subject.traits[:created_at]
      timestamp = vacancy.approved_at.to_datetime

      expect(trait[:hour]).to eql(timestamp.hour)
      expect(trait[:minute]).to eql(timestamp.min)
      expect(trait[:day]).to eql(timestamp.mday)
      expect(trait[:week]).to eql(timestamp.cweek)
      expect(trait[:month]).to eql(timestamp.month)
      expect(trait[:quarter]).to eql(quarter_for(timestamp))
      expect(trait[:year]).to eql(timestamp.year)
      expect(trait[:day_of_week]).to eql(timestamp.wday)
      expect(trait[:day_of_year]).to eql(timestamp.yday)
      expect(trait[:iso8601]).to eql(timestamp.iso8601)
    end
  end
end
