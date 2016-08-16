# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MailJob, type: :job do
  describe '#perform' do
    let(:vacancy) { persist_vacancy(build(:vacancy)) }

    it 'sends a creation notice' do
      expect do
        subject.perform('creation_notice', vacancy.id)
      end.to change { ActionMailer::Base.deliveries.size }
    end

    it 'sends an approval notice' do
      expect do
        subject.perform('approval_notice', vacancy.id)
      end.to change { ActionMailer::Base.deliveries.size }
    end
  end
end
