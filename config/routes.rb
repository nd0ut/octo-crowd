OctoCrowd::Application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)

  root 'home#index'
end
