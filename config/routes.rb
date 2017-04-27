Rails.application.routes.draw do

  root to: 'sessions#new'

  resources :users, only: %w() do
    resources :github_event_responses, path: 'github', only: %w(create)
  end

  resources :triggers, except: %w(show)
  resource :session, only: %w(new create destroy)

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create', as: 'users'

end
