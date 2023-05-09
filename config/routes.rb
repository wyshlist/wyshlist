Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  root to: "pages#home"  

  resources :organizations, only: [:new, :create, :edit, :update, :destroy, :show]

  resources :wishlists, except: :show do
    resources :wishes, only: [:new, :create, :index]
  end

  resources :wishes, only: [:show, :edit, :update, :destroy] do
    resources :votes, only: [:create]
    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  resources :votes, only: :destroy

  resources :users, only: [:show] do
    resources :wishlists, only: [:index]
  end
end
