Rails.application.routes.draw do
  root 'home#index'

  ActiveAdmin.routes(self)
  devise_for :users
end
