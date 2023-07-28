require_relative '../lib/constraints/subdomain_constraint'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'terms_of_service', to: 'pages#terms_of_service'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  unauthenticated(:user) do
    root to: "pages#home", as: :unauthenticated_root
  end

  resources :organizations, only: [:new, :create]

  authenticated(:user) do
    root to: "organizations#feedback", as: :authenticated_root
  end

  constraints SubdomainConstraint do
    resources :organizations, only: [:edit, :update, :destroy, :show]

    resources :wishlists, except: :show do
      resources :integrations, only: [:new, :create]
      resources :wishes, only: [:new, :create, :index]
    end

    resources :wishes, only: [:show, :edit, :update, :destroy] do
      resources :votes, only: [:create]
      resources :comments, only: [:create, :destroy, :edit, :update]
    end

    resources :votes, only: :destroy

    resources :integrations, only: :destroy

    resources :users, only: [:show] do
      resources :wishlists, only: [:index]
    end
  end
end
