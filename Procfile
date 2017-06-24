web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c 10
release: bundle exec rake db:migrate
