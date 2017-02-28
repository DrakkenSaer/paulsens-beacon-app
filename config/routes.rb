# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: "pages#show", page: "home", resources: { historical_events: 'HistoricalEvent' }

  resources :beacons, :historical_events, :notifications, :orders, :products, :promotions, :roles, :points

  devise_for :users, path: 'account', skip: [:sessions], path_names: { cancel: 'deactivate' }

  resources :users, only: [:index, :show] do
    resources :user_roles, path: "roles", except: [:edit, :update]
  end

  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    match 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
    get 'account', to: 'users#show', as: :account
    get 'account/points', to: 'points#show', as: :account_points
  end

end
