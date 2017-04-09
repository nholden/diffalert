Rails.application.routes.draw do

  resources :user, only: %w() do
    resource :github_event_response, path: 'github', only: %w(create)
  end

end
