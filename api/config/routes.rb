require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :orders, only: [:show]
  jsonapi_resources :restaurants do
    jsonapi_resources :dishes
  end

  resources :orders, only: :create
  mount Sidekiq::Web => '/sidekiq'
end
