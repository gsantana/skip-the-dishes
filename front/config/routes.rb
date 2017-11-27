Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :restaurants do
    resources :dishes
  end
  resources :customers

  get '/login/:customer_id', to: 'sessions#login', as: 'logmein'
  get '/logout', to: 'sessions#logout', as: 'logmeout'

  get '/orders/surprise', to: 'orders#surprise', as: 'surprise'
  get '/orders/:dish_id', to: 'orders#create', as: 'order'
  get '/orders', to: 'orders#index', as: 'orders_index'

  root to: 'sessions#index'
end
