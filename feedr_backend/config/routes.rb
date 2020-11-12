Rails.application.routes.draw do
  devise_for :users,
              path: '',
              path_names: {
                sign_in: 'login',
                registration: 'signup'
              },
              controllers: {
                sessions: 'sessions',
                registrations: 'registrations'
              }
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :caterers, only: [:index, :show]
  resources :meals
  resources :orders
  resources :order_meals, only: [:create]
  resource  :new_order, only: [:show, :create]

  devise_scope :user do
    get "/logout", to: "sessions#end"
  end
  
  get 'search', to: 'caterers#search'
  get '/', to: 'caterers#search'
  get '/current_order', to: 'new_orders#quantities'
end
