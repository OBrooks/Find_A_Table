Rails.application.routes.draw do
  root 'home#index'
  post '/put', to: 'home#put'
end
