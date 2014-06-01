Rails.application.routes.draw do
  resources :vacancies do
    get 'page/:page', :action => :index, :on => :collection
    put 'approve', :on => :member
  end
  resources :pages, :only => :show
  root :to => 'vacancies#index'
end
