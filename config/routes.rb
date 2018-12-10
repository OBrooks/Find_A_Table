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

  get "/messages",                          to: "conversations#show"  

  resources :games
  
  post "search_games", to: "games#search_games"
  get "advanced_search_games", to: "games#advanced_search_games"

  get "index",                          to: "home#index"
  get "profile",                        to: "home#profile"
  get "webmaster",                      to: "home#webmaster"
  get "admin",                          to: "home#admin"
  get "favoris",                        to: "home#favoris"
  get 'add_to_favorites',               to: "home#add_to_favorites"
  get 'remove_from_favorites',          to: "home#remove_from_favorites"

  resources :gamesession

  get "list_users",                     to:"home#list_users"
  post "webmaster",                     to: "home#scrapping"
  post "scrapping",                     to: "home#scrapping"


  get "landingpage",                    to: "landingpage#lp"

  
end
