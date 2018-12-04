Rails.application.routes.draw do
  devise_for :users
  root "home#lp"
  get "index", to: "home#index"
  get "profile", to: "home#profile"
  get "webmaster", to: "home#webmaster"
  get "admin", to: "home#admin"
end
