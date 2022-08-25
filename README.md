# 🚨  DiffAlert

Get email or Slack alerts when specific files in your GitHub repositories change

## Screenshot

<img width="1200" alt="screen shot 2017-05-18 at 6 41 08 am" src="https://cloud.githubusercontent.com/assets/7942714/26205264/1292ed12-3b96-11e7-9b6c-4657511ca06e.png">

## Installation

```
git clone git://github.com/nholden/diffalert
cd diffalert
brew install redis postgresql heroku
bundle install
bundle exec rake db:reset
cp .env.example .env
```

## Getting started

```
heroku local
```

Navigate to http://localhost:5081 (or whichever port you choose in `.env`), click "sign up," and create an account. Click "add trigger," and follow the prompts to begin receiving alerts on any file in a GitHub repository for which you have access to manage webhooks.

If you’re running DiffAlert locally, you’ll need to make your server accessible to the internet so that GitHub webhooks are able to access DiffAlert's endpoint. Consider a service like [Forward](https://forwardhq.com/). Otherwise, try deploying DiffAlert to [Heroku](https://www.heroku.com/) for free.

Slack alerts will work out of the box with [a new incoming Slack webhook](https://my.slack.com/services/new/incoming-webhook/). Email alerts are sent by Mailgun. Sign up for a free account at [mailgun.com](http://www.mailgun.com). You’ll need to update `.env` to reflect your Mailgun credentials. Unless the `RELEASE_STAGE` environment variable is set to `"production"`, all emails will be intercepted and sent to the email specified by the `NON_PRODUCTION_SEND_TO` environment variable.

Slack and email alerts are sent in the background by [Sidekiq](https://github.com/mperham/sidekiq). You can monitor Sidekiq via the web UI at http://localhost:5081/sidekiq. When you deploy DiffAlert to a production environment, the Sidekiq web UI will be protected by HTTP Basic authentication. You’ll need to set the `SIDEKIQ_USERNAME` and `SIDEKIQ_PASSWORD` environment variables in order to access the Sidekiq web UI in production.

## Testing

```
bundle exec rake
```

## Contributing

Contributions are welcome from everyone! Feel free to make a pull request or use GitHub issues for help getting started, to report bugs, or to make feature requests.

## License

This project was created by [Nick Holden](http://www.nickholden.io) and is licensed under the terms of the MIT license.
