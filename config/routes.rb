Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  namespace :admin do
    resources :events
  end

  resources :events, only: [:index, :show] do
    resources :tickets, only: [:create, :show]
  end
  resources :tickets, only: [:index]
  get 'pages/home'
end
