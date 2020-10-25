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
  resources :meals
  resources :sessions, only: [:create]
  resources :caterers, only: [:index, :show]

  devise_scope :user do
    get "/logout", to: "sessions#end"
  end
  
  get 'search', to: 'caterers#search'
  get '/', to: 'caterers#search'
end
