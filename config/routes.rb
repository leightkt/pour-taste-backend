Rails.application.routes.draw do
  resources :invitations
  resources :tastings
  resources :wines
  resources :parties
  resources :users
  post "/login", to: "users#login"
  get "/createInvite", to: "invitations#createInvite"
end
