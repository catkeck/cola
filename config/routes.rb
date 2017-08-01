Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #customers routes
  root to: 'static#home'

  #sessions routes
  get '/admins/login', to: 'sessions#admin_new', as: 'admin_login'
  post '/admins/login', to: 'sessions#admin_create'
  get '/customers/login', to: 'sessions#customer_new', as: 'customer_login'
  post '/customers/login', to: 'sessions#customer_create'
  get '/cashiers/login', to: 'sessions#cashier_new', as: 'cashier_login'
  post '/cashiers/login', to: 'sessions#cashier_create'
  post '/logout', to: 'sessions#destroy'


  get '/customers/signup', to: 'customers#new', as: 
  'customers_signup'
  post '/customers/signup', to: 'customers#create'
  get '/customers/:id', to: 'customers#show', as: 'customer'

  get '/admins/signup', to: 'admins#new', as: 'admins_signup'
  post '/admins/signup', to: 'admins#create'
  get '/admins/:id', to: 'admins#show', as: 'admin'

  resources :stores
  resources :cashiers, only: [:new, :create, :show]
  resources :visits, only: [:new, :create, :show]

  get '/stores/:id/token', to: 'stores#token', as: 'token'

  get '/cashiers/store_queue', to: 'cashiers#store_queue', as: 'store_queue'
  post '/cashiers/next', to: 'cashiers#next', as: 'next'
end
