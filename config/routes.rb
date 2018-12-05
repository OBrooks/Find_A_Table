Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  devise_for :users

    authenticated :user do
    root "home#index"
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
  
  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end


  get "/games", to: "games#index"
  get "/games/:id", to: "games#show"

  get "index", to: "home#index"
  get "profile", to: "home#profile"
  get "webmaster", to: "home#webmaster"
  get "admin", to: "home#admin"
  get "list_users", to:"home#list_users"

  get "landingpage", to: "landingpage#lp"
end
