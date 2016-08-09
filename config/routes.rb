Rails.application.routes.draw do
  root :to => 'vacancies#index'

  resources :vacancies do
    get 'page/:page', action: :index, on: :collection
    put 'approve', on: :member
  end
  resources :pages, only: :show
  resource :sitemap, only: :show
end
