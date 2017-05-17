# 🚨  DiffAlert

Get email or Slack alerts when specific files in your GitHub repositories change

## Demo

Try it out for yourself at [http://diffalert.nickholden.io](http://diffalert.nickholden.io).

## Installation

```
git clone git://github.com/nholden/diffalert
cd diffalert
bundle install

bundle exec rake db:reset
cp .env.example .env
```

## Getting started

```
rails s
```

Navigate to http://localhost:5081 (or whichever port you choose in `.env`), click "sign up," and create an account. Click "add trigger," and follow the prompts to begin receiving alerts on any file in a GitHub repository for which you have access to manage webhooks.

If you’re running DiffAlert locally, you’ll need to make your server accessible to the internet so that GitHub webhooks are able to access DiffAlert's endpoint. Consider a service like [Forward](https://forwardhq.com/). Otherwise, try deploying DiffAlert to [Heroku](https://www.heroku.com/) for free.

Slack alerts will work out of the box with [a new incoming Slack webhook](https://my.slack.com/services/new/incoming-webhook/). Email alerts are sent by Mailgun. Sign up for a free account at [mailgun.com](http://www.mailgun.com). You’ll need to update `.env` to reflect your Mailgun credentials.

## Testing

```
bundle exec rake
```

## Contributing

Contributions are welcome from everyone! Feel free to make a pull request or use GitHub issues for help getting started, to report bugs, or to make feature requests.

## License

This project was created by [Nick Holden](http://www.nickholden.io) and is licensed under the terms of the MIT license.
