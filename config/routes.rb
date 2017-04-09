Rails.application.routes.draw do

  resources :users, only: %w(new create), path_names: { new: 'signup' } do
    resources :triggers, only: %w(index)
    resources :github_event_responses, path: 'github', only: %w(create)
  end


end
