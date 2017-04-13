Rails.application.routes.draw do

  root to: proc { [200, {'Content-Type' => 'text/plain'}, ["Nothing to see here, yet."]] }

  resources :users, only: %w() do
    resources :github_event_responses, path: 'github', only: %w(create)
  end

  resources :triggers, only: %w(index new create destroy)
  resource :session, only: %w(new create destroy)

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create', as: 'users'

end
