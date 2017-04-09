Rails.application.routes.draw do

  root to: 'sessions#new'

  resources :users, only: %w() do
    resources :triggers, only: %w(index)
    resources :github_event_responses, path: 'github', only: %w(create)
  end

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create', as: 'users'

  get '/login', to: 'sessions#new', as: 'new_session'
  post '/login', to: 'sessions#create', as: 'sessions'

end
