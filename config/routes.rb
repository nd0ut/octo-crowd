require 'sidekiq/web'

OctoCrowd::Application.routes.draw do

  # USERS
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations"
  }


  # POSTS
  resources :posts do
    resources :comments, only: [:create, :destroy], shallow: true

    collection do
      get 'search(/:q)', to: 'posts#search', as: :search
      get 'page/:page', to: 'posts#index'
    end
  end


  # CATEGORIES
  resources :categories, only: [:show] do
    member do
      post 'unsubscribe'
      post 'subscribe'
    end
  end


  # SUBSCRIPTIONS
  resource :subscriptions, only: [:show] do
    collection do
      get 'reset/:signature' => 'subscriptions#reset', as: 'reset'
    end
  end


  # OTHER
  mount RedactorRails::Engine => '/redactor_rails'

  ActiveAdmin.routes(self)

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'posts#index'
end

