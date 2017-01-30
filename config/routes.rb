Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  namespace :admin do
    resources :events
  end

  resources :events, only: [:index, :show]
  resources :tickets, only: [:new, :create, :show]
  get 'pages/home'
end
