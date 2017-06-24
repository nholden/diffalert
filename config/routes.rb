require "sidekiq/web"

Rails.application.routes.draw do

  root to: 'home#show'

  resources :users, only: %w() do
    resources :github_event_responses, path: 'github', only: %w(create)
    resource :email_confirmation, only: %w(new), controller: 'user_email_confirmations'
  end

  resources :triggers, except: %w(show)
  resources :trigger_builders, only: %w(new create)
  resource :session, only: %w(new create destroy)

  get '/signup', to: 'user_registrations#new', as: 'new_user_registration'
  post '/signup', to: 'user_registrations#create', as: 'user_registrations'

  get '/setup', to: 'trigger_setup_instructions#show', as: 'trigger_setup_instructions'

  # Sidekiq UI with HTTP Basic authentication
  # https://github.com/mperham/sidekiq/wiki/Monitoring
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?

  mount Sidekiq::Web, at: "/sidekiq"
end
