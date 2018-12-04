Rails.application.routes.draw do
  root "home#lp"

  get "/games", to: "games#index"
  get "/games/:id", to: "games#show"


end
