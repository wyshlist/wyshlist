Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'terms_of_service', to: 'pages#terms_of_service'
  
  authenticated(:user) do
    root to: "wishlists#index", as: :authenticated_root
  end
  
  unauthenticated(:user) do
    root to: "pages#home", as: :unauthenticated_root
  end

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
