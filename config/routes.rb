Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy", as: "logout"
  get "profile", to: "users#show", as: "profile"
  get "profile/edit", to: "users#edit", as: "profile_edit"
  get "dashboard", to: "static#dashboard", as: "dashboard"
  resources :users, only: [:index, :new, :create, :show, :edit]
  resources :events
  resources :sessions, only: [:new, :create, :destroy]
end
