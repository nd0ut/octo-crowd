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
  end

  resources :categories

  root 'posts#index'

  get '/page/:page', to: 'posts#index'
end
