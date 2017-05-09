# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: "pages#show", page: "home"

  resources :beacons, :historical_events, :notifications, :orders, :products, :promotions, :roles, :points

  devise_for :users, path: 'account', skip: [:sessions], path_names: { cancel: 'deactivate' }, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    resources :users, controller: 'users/registrations', only: [:index, :show, :edit, :update] do
      resources :user_roles, path: "roles", except: [:edit, :update]
    end

    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    match 'logout', to: 'users/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
    get 'account', to: 'users/registrations#show', as: :account
    get 'account/points', to: 'points#show', as: :account_points

    namespace :api, constraints: { format: 'json' } do
      post 'login', to: 'users/sessions#create', as: :user_session
      match 'logout', to: 'users/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
    end
  end
end
