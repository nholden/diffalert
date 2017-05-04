Rails.application.routes.draw do

  root to: 'sessions#new'

  resources :users, only: %w() do
    resources :github_event_responses, path: 'github', only: %w(create)
  end

  resources :triggers, except: %w(show)
  resources :trigger_builders, only: %w(new create)
  resource :session, only: %w(new create destroy)

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create', as: 'users'

  get '/setup', to: 'trigger_setup_instructions#show', as: 'trigger_setup_instructions'

end
