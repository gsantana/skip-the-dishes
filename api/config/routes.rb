require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :orders, only: [:show]
  jsonapi_resources :restaurants do
    jsonapi_resources :dishes, except: [:create]
  end

  resources :restaurants do
    resources :dishes, only: [:create]
  end

  resources :orders, only: :create
  mount Sidekiq::Web => '/sidekiq'
end
