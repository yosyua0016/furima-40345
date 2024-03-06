Rails.application.routes.draw do
  devise_for :users

  as :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :logout
  end

  root to: "items#index"
  resources :items
  end