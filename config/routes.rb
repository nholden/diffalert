Rails.application.routes.draw do

  resource :github_event, path: 'github', only: %w(create)

end
