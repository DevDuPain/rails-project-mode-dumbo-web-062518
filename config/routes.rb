Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "profile", to: "users#show", as: "profile"
  resources :users, only: [:index, :show]
  resources :events
end
