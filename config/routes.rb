Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  get 'session_new', to: 'sessions#new'
  post 'session_create', to: 'sessions#login'
  get 'session_destroy', to: 'sessions#logout'

  resources :players
  resources :matches do
    collection do
      get 'new_month', to: 'matches#new_month'
      post 'create_month', to: 'matches#create_month'
    end
  end
  resources :payments do
    collection do
      get 'new_match_payment', to: 'payments#new_match_payment'
      post 'create_match_payment', to: 'payments#create_match_payment'

      get 'new_month_payment', to: 'payments#new_month_payment'
      post 'create_month_payment', to: 'payments#create_month_payment'

      get 'new_credit', to: 'payments#new_credit'
      post 'create_credit', to: 'payments#create_credit'

      get 'new_debit', to: 'payments#new_debit'
      post 'create_debit', to: 'payments#create_debit'
    end
  end
end
