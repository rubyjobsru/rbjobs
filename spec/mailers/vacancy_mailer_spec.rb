# frozen_string_literal: true
require 'rails_helper'

RSpec.describe VacancyMailer do
  let(:vacancy) { create(:vacancy) }

  describe '.creation_notice' do
    it 'delivers message to support email' do
      email = described_class.creation_notice(vacancy).deliver
      expect(email.to).to include(ENV['SUPPORT_EMAIL'])
    end
  end

  describe '.approval_notice' do
    it 'should deliver message to owner' do
      email = described_class.approval_notice(vacancy).deliver
      expect(email.to).to include(vacancy.email)
    end
  end
end
