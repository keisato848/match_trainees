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
  resources :retirements, only: [:new, :create]
  resources :searches, only: :index 

  # 落穂拾い用に全てのURLをキャッチ
  match "*path" => "application#error404", via: :all
end
