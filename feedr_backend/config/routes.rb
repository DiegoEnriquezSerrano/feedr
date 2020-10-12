Rails.application.routes.draw do
  devise_for :users,
              path: '',
              path_names: {
                sign_in: 'login',
                sign_out: 'logout',
                registration: 'signup'
              },
              controllers: {
                sessions: 'sessions',
                registrations: 'registrations'
              }
  resources :users, only: [:create]
  resources :meals
  resources :sessions, only: [:create, :destroy]
  
  get 'caterers', to: 'caterers#index'
end
