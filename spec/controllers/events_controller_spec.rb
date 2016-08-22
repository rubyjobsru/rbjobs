# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe '#create' do
    let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }
    let(:parameters) { { vacancy_id: vacancy.id, event_code: 'foo' } }

    it 'responds with "HTTP 204 No Content"' do
      post :create, params: parameters
      expect(response.status).to eql(204)
    end

    it 'sets a background job for publishing to Keen IO' do
      expect do
        post :create, params: parameters
      end.to have_enqueued_job(KeenJob)
    end

    context 'when a vacancy does not exist' do
      before { parameters[:vacancy_id] = 'wrong-id' }

      it 'responds with "HTTP 404 Not Found"' do
        post :create, params: parameters
        expect(response.status).to eql(404)
      end
    end
  end
end
