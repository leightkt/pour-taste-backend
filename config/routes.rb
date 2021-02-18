Rails.application.routes.draw do
  resources :invitations
  resources :tastings
  resources :wines
  resources :parties
  resources :users
  post "/login", to: "users#login"
  get "/createInvite", to: "invitations#createInvite"
  get "/viewtastings", to: "users#tastings"
  get "/addtastings", to: "tastings#addTasting"
  post "/partydeets", to: "parties#partydeets"
  post "/userpartydeets", to: "parties#user_partydeets"
  delete "/deletetasting", to: "tastings#delete_host_tasting"
end
