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

  resources :categories

  root 'posts#index'

  get '/page/:page', to: 'posts#index'
end
