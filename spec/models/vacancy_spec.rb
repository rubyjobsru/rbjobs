require 'rails_helper'

RSpec.describe Vacancy do
  subject { build(:vacancy) }

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

  context 'when vacancy has been saved' do
    before { subject.save! }

    it 'assigns an owner token' do
      expect(subject.owner_token).not_to be_blank
    end

    it 'assigns an admin token' do
      expect(subject.admin_token).not_to be_blank
    end

    it 'generates excerpt' do
      expect(subject.excerpt_html).not_to be_blank
    end

    it 'generates html description' do
      expect(subject.description_html).not_to be_blank
    end
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
    context 'when vacancy does not have approval mark' do
      before do
        subject.approved_at = nil
        subject.approve!
      end

      it { is_expected.to be_approved }

      it { is_expected.to be_persisted}
    end

    context 'when vacancy have approval mark' do
      before do
        subject.approved_at = Date.current
        subject.approve!
      end

      it { is_expected.to be_approved }

      it { is_expected.to be_persisted}
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
