Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :orders, only: [:create]
  jsonapi_resources :restaurants do
    jsonapi_resources :dishes
  end
end
