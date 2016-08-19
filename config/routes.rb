# frozen_string_literal: true
Rails.application.routes.draw do
  root to: 'vacancies#index'

  resources :pages, only: :show
  resource  :sitemap, only: :show
  resources :vacancies do
    put 'approve', on: :member
    resources :events, only: :create
    get 'page/:page', action: :index, on: :collection
  end
end
