Rails.application.routes.draw do
  devise_for :users

    authenticated :user do
    root "home#lp"
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
  
  get 'chat' => 'conversations#show'
  resources :conversations do
      resources :messages
  end

  get "/games", to: "games#index"
  get "/games/:id", to: "games#show"

  get "index", to: "home#index"
  get "profile", to: "home#profile"
  get "webmaster", to: "home#webmaster"
  get "admin", to: "home#admin"
  get "list_users", to:"home#list_users"
end
