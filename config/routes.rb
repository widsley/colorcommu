LanguageSchools::Application.routes.draw do
  root to: 'main#index'

  namespace :operator do
    root to: 'main#index'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :operators
    resources :password_resets
    resources :sessions
  end
end
