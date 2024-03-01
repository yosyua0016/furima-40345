Rails.application.routes.draw do
  devise_for :users

  as :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :logout
  end

 root "items#index"
 resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
end
end