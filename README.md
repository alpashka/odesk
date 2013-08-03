# Odesk

Ruby gem to interact with the [ODesk REST api](http://developers.odesk.com/w/page/12363985/API%20Documentation).

## Installation

Add this line to your application's Gemfile:

    gem 'odesk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install odesk

## Usage

### Setup

The ODesk API uses OAuth 1.0 for authenticating requests, so you will first need to [register your application with ODesk](https://www.odesk.com/services/api/keys) to obtain a consumer key and secret. Then complete the following process to obtain an access token:

    Odesk.configure do |config|
      config.consumer_key = YOUR_ODESK_KEY
      config.consumer_secret = YOUR_ODESK_SECRET
      config.callback_url = FULLY_QUALIFIED_URL  #e.g. http://localhost:3001/oauth/callback
    end

Send your user to the `Odesk.authorize_url` and once they have agreed to allow you application access to their ODesk data they will be redirected to your callback URL with with `oauth_token` and `oauth_verifier` parameters added to the query string.

Then to obtain an access token:

    Odesk.get_access_token("oauth_token", "oauth_verifier")
    # => {:oauth_token => "ACCESS_TOKEN", :oauth_token_secret => "SECRET"}

You will then be able to make authenticated requests to the API.

The access tokens will never expire so to skip this process in future sessions you can save these two keys and then supply then straight to configure:

    Odesk.configure do |config|
      config.consumer_key = YOUR_ODESK_KEY
      config.consumer_secret = YOUR_ODESK_SECRET
      config.oauth_token = "ACCESS_TOKEN"
      config.oauth_token_secret = "SECRET"
    end
    
    #=> Odesk ready to make requests...

## Supported Ruby Versions
This library aims to support the following Ruby implementations:

* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright
Copyright (c) 2013 Michael Vigor. See [LICENSE][] for details.

[license]: LICENSE
