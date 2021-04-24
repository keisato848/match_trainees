Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'welcome#index'
  resources :users, only: [:show, :edit, :update] do
    resources :training_scores, only: [:new, :create, :edit, :update]
  end
  resources :trainings do
    resources :tickets, only: [:create, :destroy]
  end 
  resources :users, only: [:new, :destroy]
  resources :retirements, only: [:new, :create]
  resources :searches, only: :index 

end
