# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Trackable do
  include DateTimeHelpers

  let(:event) { create(:event, vacancy: vacancy, visitor: visitor) }
  let(:vacancy) { persist_vacancy(build(:vacancy)) }
  let(:visitor) { create(:visitor) }

  subject { described_class.new(event) }

  it 'decorates subject with #traits method' do
    expect(subject).to respond_to(:traits)
  end

  it 'decorates subject with #vacancy method' do
    expect(subject).to respond_to(:vacancy)
  end

  it 'decorates subject with #visitor method' do
    expect(subject).to respond_to(:visitor)
  end

  describe '#traits' do
    it 'represents a creation timestamp as a hash' do
      trait = subject.traits[:created_at]
      timestamp = event.created_at.to_datetime

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

    it 'includes vacancy traits' do
      vacancy_traits = Vacancies::Trackable.new(vacancy).traits

      expect(subject.traits[:vacancy]).to eql(vacancy_traits)
    end

    it 'includes visitor traits' do
      visitor_traits = Visitors::Trackable.new(visitor).traits

      expect(subject.traits[:visitor]).to eql(visitor_traits)
    end
  end

  describe '#vacancy' do
    it 'returs a trackable vacancy' do
      expect(subject.vacancy).to be_a(Vacancies::Trackable)
    end
  end

  describe '#visitor' do
    it 'returs a trackable visitor' do
      expect(subject.visitor).to be_a(Visitors::Trackable)
    end
  end
end
