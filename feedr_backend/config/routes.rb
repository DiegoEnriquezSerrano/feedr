Rails.application.routes.draw do
  resources :orders
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
  resources :order_meals
  resource  :new_order, only: [:show]

  devise_scope :user do
    get "/logout", to: "sessions#end"
  end
  
  get 'search', to: 'caterers#search'
  get '/', to: 'caterers#search'
end
