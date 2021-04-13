Rails.application.routes.draw do
  resources :trainings
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'welcome#index'
  resources :users, only: [:new, :destroy]
end
