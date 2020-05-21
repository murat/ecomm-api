# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users,
             path: 'auth',
             path_names: { sign_up: 'register', sign_in: 'login', sign_out: 'logout' },
             controllers: {
               registrations: 'auth/registrations',
             },
             skip: [:sessions, :password]

  use_doorkeeper

  get :health, to: 'health#index'

  namespace :api do
    namespace :v1 do
      get :account, to: 'accounts#show'

      resources :brands, except: %i(new edit)
      resources :categories, except: %i(new edit)
      resources :products, except: %i(new edit)

      resources :addresses, except: %i(new edit)
      get :cart, to: 'carts#show'
      post :'cart/add', to: 'carts#add'
      delete :'cart/drop/:product_id', to: 'carts#drop', as: :cart_drop
      put :'cart/update/:product_id', to: 'carts#update', as: :cart_update
      put :'cart/increment/:product_id', to: 'carts#increment', as: :cart_increment
      put :'cart/decrement/:product_id', to: 'carts#decrement', as: :cart_decrement
      resources :orders, except: %i(new edit destroy)
    end
  end
end
