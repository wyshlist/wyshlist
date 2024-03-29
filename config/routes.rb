Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'privacy_policy', to: 'pages#privacy_policy', as: :privacy
  get 'terms_of_service', to: 'pages#terms_of_service', as: :terms

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  unauthenticated :user do
    root to: "pages#home", as: :unauthenticated_root
  end

  get '/get-started', to: 'pages#home', as: :get_started

  resources :organizations, only: [:new, :create]

  authenticated :user do
    root to: 'passthrough#index', as: :authenticated_root
  end

  constraints SubdomainConstraint do
    get '/feedback', to: 'organizations#feedback', as: :feedback
    get '/boards', to: 'organizations#boards', as: :boards
    resources :organizations, only: [:edit, :update, :destroy]

    get '/members', to: 'organizations#members'
    patch '/remove_members/:user_id', to: 'organizations#remove_member', as: :remove_member

    resources :wishlists, except: :show do
      resources :integrations, only: [:new, :create]
      resources :wishes, only: [:new, :create, :index]
    end

    resources :wishes, only: [:create]

    resources :wishes, only: [:show, :edit, :update, :destroy] do
      resources :votes, only: [:create]
      resources :comments, only: [:create, :destroy, :edit, :update]
    end

    resources :votes, only: :destroy

    resources :integrations, only: :destroy
  end
end
