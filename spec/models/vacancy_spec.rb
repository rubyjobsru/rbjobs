# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Vacancy do
  subject { persist_vacancy(build(:vacancy)) }

  it 'is not valid without title' do
    subject.title = nil
    expect(subject).not_to be_valid
    expect(subject.errors).to include(:title)
  end

  it 'is not valid without description' do
    subject.description = nil
    expect(subject).not_to be_valid
    expect(subject.errors).to include(:description)
  end

  it 'is not valid without location' do
    subject.location = nil
    expect(subject).not_to be_valid
    expect(subject.errors).to include(:location)
  end

  it 'is not valid without email' do
    subject.email = nil
    expect(subject).not_to be_valid
    expect(subject.errors).to include(:email)
  end

  it 'is not valid with email in wrong format' do
    subject.email = 'wrong@email'
    expect(subject).not_to be_valid
    expect(subject.errors).to include(:email)
  end

  it 'is not valid without expiration date' do
    subject.expire_at = nil
    expect(subject).not_to be_valid
    expect(subject.errors).to include(:expire_at)
  end

  describe '#approved?' do
    context 'when vacancy has approval mark' do
      before { subject.approved_at = Date.current }

      it { is_expected.to be_approved }
    end

    context 'when vacancy does not have approval mark' do
      before { subject.approved_at = nil }

      it { is_expected.not_to be_approved }
    end
  end

  describe '#approve!' do
    context 'when vacancy does not have approval timestamp' do
      before { subject.update!(approved_at: nil) }

      it 'sets an approval timestamp on the vacancy' do
        subject.approve!
        expect(subject.approved_at).not_to be_nil
      end
    end

    context 'when vacancy have approval timestamp' do
      let(:approval_timestamp) { Time.current - 1.day }

      before { subject.update!(approved_at: approval_timestamp) }

      it 'does not change an approval timestamp on the vacancy' do
        expect do
          subject.approve!
        end.not_to change { subject.approved_at }
      end
    end
  end

  describe '#refuse!' do
    context 'when vacancy have approval timestamp' do
      before { subject.update!(approved_at: Time.current) }

      it 'drops an approval timestamp on the vacancy' do
        subject.refuse!
        expect(subject.approved_at).to be_nil
      end
    end

    context 'when vacancy does not have approval timestamp' do
      before { subject.update!(approved_at: nil) }

      it 'does not change an approval timestamp on the vacancy' do
        expect do
          subject.refuse!
        end.not_to change { subject.approved_at }
      end
    end
  end

  describe '#expired?' do
    context 'when expiration date is in the future' do
      before { subject.expire_at = 2.days.from_now }

      it { is_expected.not_to be_expired }
    end

    context 'when expiration date is in the past' do
      before { subject.expire_at = 2.days.ago }

      it { is_expected.to be_expired }
    end
  end
end
