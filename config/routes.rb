Rails.application.routes.draw do
  get "search/index"
  get "pages/about"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root 'countries#index'
  
  get 'about', to: 'pages#about'
  
  resources :countries, only: [:index, :show] do
    resources :cities, only: [:index]
  end
  
  resources :cities, only: [:show] do
    resources :attractions, only: [:index]
  end
  
  resources :attractions, only: [:show]
  
  # 搜索路由
  get 'search', to: 'search#index'
end
