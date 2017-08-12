Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  get 'session_new', to: 'sessions#new'
  post 'session_create', to: 'sessions#login'
  get 'session_destroy', to: 'sessions#logout'

  resources :players
end
