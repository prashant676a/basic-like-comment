Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")

  root "posts#index"
  resource :profile, only: [:show]

  resources :posts do
    resources :likes, only: [ :create, :destroy ]
    resources :comments do
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :friend_requests, only: [:create, :destroy, :index, :update] do
    collection do
      get :show_friends
      get :suggestions
    end
  end
end