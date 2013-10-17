OctoCrowd::Application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations"
  }

  post "/auth/:provider/callback" => "authentications#create"

  ActiveAdmin.routes(self)

  resources :posts
  resources :categories

  root 'home#index'
end
