Rails.application.routes.draw do
  resources :organizations, only: [:new, :create]
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :wishlists do
    resources :wishes, only: [:new, :create]
  end

  resources :wishes, only: [:show, :edit, :update, :destroy] do
    resources :votes, only: [:create]
    resources :comments, only: [:create]
  end

  resources :users, only: [:show] do
    resources :wishlists, only: [:index]
  end
end
