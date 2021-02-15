Rails.application.routes.draw do
  resources :tastings
  resources :wines
  resources :parties
  resources :users
  post "/login", to: "users#login"
end
