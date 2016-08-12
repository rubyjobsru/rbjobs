# frozen_string_literal: true
require 'rails_helper'

RSpec.describe VacanciesController do
  describe '#index' do
    it 'responds with "HTTP 200 OK"' do
      get :index
      expect(response.status).to eql(200)
    end
  end

  describe '#new' do
    it 'responds with "HTTP 200 OK"' do
      get :new
      expect(response.status).to eql(200)
    end
  end

  describe '#create' do
    let(:attributes) { attributes_for(:vacancy) }
    let(:parameters) { { vacancy: attributes } }

    it 'responds with "HTTP 303 See Other"' do
      post :create, params: parameters
      expect(response.status).to eql(303)
    end

    it 'redirects to the root URL' do
      post :create, params: parameters
      expect(response.location).to eql(root_url)
    end

    it 'sets a background job for email delivery' do
      expect do
        post :create, params: parameters
      end.to have_enqueued_job(ActionMailer::DeliveryJob)
    end

    it 'sends an email notification to the admin' do
      perform_enqueued_jobs do
        post :create, params: parameters
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eql(ENV['SUPPORT_EMAIL'])
    end

    context 'when supplied non-valid vacancy attributes' do
      before { attributes[:title] = nil }

      it 'responds with "HTTP 422 Unprocessable Entity"' do
        post :create, params: parameters
        expect(response.status).to eql(422)
      end

      it 'does not redirect to anywhere' do
        post :create, params: parameters
        expect(response.location).to be_nil
      end
    end
  end

  describe '#show' do
    let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }
    let(:parameters) { { id: vacancy.id } }

    it 'responds with "HTTP 200 OK"' do
      get :show, params: parameters
      expect(response.status).to eql(200)
    end

    context 'when a vacancy does not exist' do
      before { parameters[:id] = 'wrong-id' }

      it 'responds with "HTTP 404 Not Found"' do
        get :show, params: parameters
        expect(response.status).to eql(404)
      end
    end

    context 'when a vacancy is not approved yet' do
      before { vacancy.refuse! }

      it 'responds with "HTTP 404 Not Found"' do
        get :show, params: parameters
        expect(response.status).to eql(404)
      end

      context 'and an admin token is supplied' do
        before { parameters[:token] = vacancy.admin_token }

        it 'responds with "HTTP 200 OK"' do
          get :show, params: parameters
          expect(response.status).to eql(200)
        end
      end
    end
  end

  describe '#edit' do
    let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }
    let(:parameters) { { id: vacancy.id, token: vacancy.owner_token } }

    it 'responds with "HTTP 200 OK"' do
      get :edit, params: parameters
      expect(response.status).to eql(200)
    end

    context 'when a vacancy does not exist' do
      before { parameters[:id] = 'wrong-id' }

      it 'responds with "HTTP 404 Not Found"' do
        get :edit, params: parameters
        expect(response.status).to eql(404)
      end
    end

    context 'when a vacancy is not approved yet' do
      before { vacancy.refuse! }

      it 'responds with "HTTP 404 Not Found"' do
        get :edit, params: parameters
        expect(response.status).to eql(404)
      end

      context 'and an admin token is supplied' do
        before { parameters[:token] = vacancy.admin_token }

        it 'responds with "HTTP 200 OK"' do
          get :edit, params: parameters
          expect(response.status).to eql(200)
        end
      end
    end
  end

  describe '#update' do
    let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }
    let(:attributes) { attributes_for(:vacancy) }
    let(:parameters) do
      {
        id: vacancy.id,
        token: vacancy.owner_token,
        vacancy: attributes
      }
    end

    it 'responds with "HTTP 303 See Other"' do
      put :update, params: parameters
      expect(response.status).to eql(303)
    end

    it 'redirects to the vacancy URL' do
      put :update, params: parameters
      expect(response.location).to eql(vacancy_url(vacancy))
    end

    context 'when supplied non-valid vacancy attributes' do
      before { attributes[:title] = nil }

      it 'responds with "HTTP 422 Unprocessable Entity"' do
        put :update, params: parameters
        expect(response.status).to eql(422)
      end

      it 'does not redirect to anywhere' do
        put :update, params: parameters
        expect(response.location).to be_nil
      end
    end

    context 'when a vacancy does not exist' do
      before { parameters[:id] = 'wrong-id' }

      it 'responds with "HTTP 404 Not Found"' do
        put :update, params: parameters
        expect(response.status).to eql(404)
      end
    end

    context 'when a vacancy is not approved yet' do
      before { vacancy.refuse! }

      it 'responds with "HTTP 404 Not Found"' do
        put :update, params: parameters
        expect(response.status).to eql(404)
      end

      context 'and an admin token is supplied' do
        before { parameters[:token] = vacancy.admin_token }

        it 'responds with "HTTP 303 See Other"' do
          put :update, params: parameters
          expect(response.status).to eql(303)
        end
      end
    end
  end

  describe '#destroy' do
    let(:vacancy) { persist_vacancy(build(:approved_vacancy)) }
    let(:parameters) { { id: vacancy.id, token: vacancy.admin_token } }

    it 'responds with "HTTP 303 See Other"' do
      delete :destroy, params: parameters
      expect(response.status).to eql(303)
    end

    it 'redirects to the root URL' do
      delete :destroy, params: parameters
      expect(response.location).to eql(root_url)
    end

    context 'when a vacancy does not exist' do
      before { parameters[:id] = 'wrong-id' }

      it 'responds with "HTTP 404 Not Found"' do
        delete :destroy, params: parameters
        expect(response.status).to eql(404)
      end
    end

    context 'when an owner token is supplied' do
      before { parameters[:token] = vacancy.owner_token }

      it 'responds with "HTTP 404 Not Found"' do
        delete :destroy, params: parameters
        expect(response.status).to eql(404)
      end
    end
  end

  describe '#approve' do
    let(:vacancy) { persist_vacancy(build(:vacancy)) }
    let(:parameters) { { id: vacancy.id, token: vacancy.admin_token } }

    it 'responds with "HTTP 303 See Other"' do
      put :approve, params: parameters
      expect(response.status).to eql(303)
    end

    it 'redirects to the vacancy URL' do
      put :approve, params: parameters
      expect(response.location).to eql(vacancy_url(vacancy))
    end

    it 'sets a background job for email delivery' do
      expect do
        put :approve, params: parameters
      end.to have_enqueued_job(ActionMailer::DeliveryJob)
    end

    it 'sends an email notification to the owner' do
      perform_enqueued_jobs do
        put :approve, params: parameters
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eql(vacancy.email)
    end

    context 'when a vacancy does not exist' do
      before { parameters[:id] = 'wrong-id' }

      it 'responds with "HTTP 404 Not Found"' do
        put :approve, params: parameters
        expect(response.status).to eql(404)
      end
    end

    context 'when an owner token is supplied' do
      before { parameters[:token] = vacancy.owner_token }

      it 'responds with "HTTP 404 Not Found"' do
        put :approve, params: parameters
        expect(response.status).to eql(404)
      end
    end
  end
end
