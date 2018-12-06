Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  devise_for :users

    # authenticated :user do
    root "home#index"
  # end

  # unauthenticated :user do
  #   devise_scope :user do
  #     get "/" => "devise/sessions#new"
  #   end
  # end

  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end

  resources :games

  get "index", to: "home#index"
  get "profile", to: "home#profile"
  get "webmaster", to: "home#webmaster"
  get "admin", to: "home#admin"
  resources :gamesession
  get "list_users", to:"home#list_users"
  post "scrapping", to: "home#scrapping"

  get "landingpage", to: "landingpage#lp"

  get "joingame", to: "gamesession#joingame"
  get "leavegame", to: "gamesession#leavegame"

end
