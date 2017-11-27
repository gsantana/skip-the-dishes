Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :restaurants do
    resources :dishes
  end
  resources :customers
  root to: 'restaurants#index'

  get '/login/:customer_id', to: 'sessions#login', as: 'logmein'
  get '/logout', to: 'sessions#logout', as: 'logmeout'

  get '/order/:dish_id', to: 'orders#create', as: 'order'
end
