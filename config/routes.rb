Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  
  root to: "pages#show", page: "home"
  
  resources :beacon, :historical_event, :notification, :order, :product, :promotion, :role
end
