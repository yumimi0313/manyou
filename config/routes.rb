Rails.application.routes.draw do
  resources :tasks do
    get :search, on: :collection
  end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
end
