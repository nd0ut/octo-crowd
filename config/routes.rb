require 'sidekiq/web'

OctoCrowd::Application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations"
  }

  post "/auth/:provider/callback" => "authentications#create"

  ActiveAdmin.routes(self)

  resources :posts do
    post 'comments', to: 'posts/comments#create'
    delete 'comments/:comment_id', to: 'posts/comments#destroy', as: :destroy_comment
  end

  post 'posts/preview', to: 'posts#preview', as: :post_preview

  resources :categories do
    post 'unsubscribe'
    post 'subscribe'
  end

  get '/tag/:tag', to: 'posts#by_tag', as: :tag_search
  post '/search', to: 'posts#search', as: :search

  root 'posts#index'
  get '/page/:page', to: 'posts#index'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

