Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"  

  resources :organizations, only: [:new, :create]

  resources :wishlists, except: :show do
    resources :wishes, only: [:new, :create, :index]
  end

  resources :wishes, only: [:show, :edit, :update, :destroy] do
    resources :votes, only: [:create]
    resources :comments, only: [:create]
  end

  resources :users, only: [:show] do
    resources :wishlists, only: [:index]
  end
end
