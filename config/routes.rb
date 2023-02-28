Rails.application.routes.draw do
  resources :tasks do
    get :search, on: :collection
  end
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :destroy]
end
