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
    end
  end
end
