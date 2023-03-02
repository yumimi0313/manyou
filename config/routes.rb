Rails.application.routes.draw do
  resources :labels
  root to: 'tasks#index'
  resources :tasks do
    get :search, on: :collection
  end
  resources :users
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :destroy]
end
