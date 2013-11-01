require 'sidekiq/web'

OctoCrowd::Application.routes.draw do

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations"
  }


  resource :subscriptions, only: [:show] do

    collection do
      get 'unsubscribe/:signature' => 'subscriptions#unsubscribe', as: 'unsubscribe'
    end
  end


  resources :posts do
    resources :comments, only: [:create, :destroy], shallow: true

    collection do
      get 'search(/:q)', to: 'posts#search', as: :search
      get 'page/:page', to: 'posts#index'
    end
  end


  resources :categories, only: [:show] do

    member do
      post 'unsubscribe'
      post 'subscribe'
    end
  end



  mount RedactorRails::Engine => '/redactor_rails'


  ActiveAdmin.routes(self)


  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


  root 'posts#index'
end

