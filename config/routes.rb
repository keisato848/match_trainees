Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'welcome#index'
  resources :trainings do
    resources :tickets, only: [:create, :destroy]
  end 
  resources :users, only: [:new, :destroy]
end
