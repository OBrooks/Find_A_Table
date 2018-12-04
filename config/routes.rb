Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "landingpage", to: "landingpage#lp"
  get "/games", to: "games#index"
  get "/games/:id", to: "games#show"

  get "index", to: "home#index"
  get "profile", to: "home#profile"
  get "webmaster", to: "home#webmaster"
  get "admin", to: "home#admin"
  resources :session
end
