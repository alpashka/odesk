# encoding: utf-8
require 'faraday'
require 'faraday_middleware'

module Odesk
  class OauthError < StandardError
  end

  # Handles the connection to oDesk with oauth authentication
  module Connection
    def connection
      validate_configuration!

      Faraday.new(Odesk.endpoint, faraday_options) do |conn|
        conn.request :oauth, oauth_options
        conn.request :url_encoded
        conn.adapter *Odesk.faraday_adapter
      end
    end

    def authorize_url
      extract_tokens(connection.post '/api/auth/v1/oauth/token/request')
      querystring = URI.encode_www_form(authorize_request_params)
      "#{Odesk.endpoint}/services/api/auth?#{querystring}"
    end

    def get_access_token(verifier_token)
      validate_access_request!
      Odesk.verifier_token = verifier_token
      extract_tokens(connection.post '/api/auth/v1/oauth/token/access')
    end

    private

    def validate_configuration!
      validate_consumer_key
      validate_consumer_secret
    end

    def validate_consumer_key
      unless Odesk.consumer_key
        raise InvalidConfigurationError, 'The consumer key is not set'
      end
    end

    def validate_consumer_secret
      unless Odesk.consumer_secret
        raise InvalidConfigurationError, 'The consumer secret is not set'
      end
    end

    def validate_access_request!
      unless Odesk.oauth_token && Odesk.oauth_token_secret
        raise OauthError, 'Oauth token and secret requrired'
      end
    end

    def faraday_options
      { headers: {
          user_agent: Odesk.user_agent
        } }
    end

    def extract_tokens(response)
      tokens = Hash[URI.decode_www_form(response.body)]
      save_oauth_tokens(tokens)
      tokens.reduce({}) { |memo, (k, v)| memo[k.to_sym] = v; memo }
    end

    def save_oauth_tokens(tokens)
      Odesk.oauth_token = tokens['oauth_token']
      Odesk.oauth_token_secret = tokens['oauth_token_secret']
    end

    def authorize_request_params
      { oauth_callback: Odesk.callback_url,
        oauth_token: Odesk.oauth_token }
    end

    def oauth_options
      { consumer_key: Odesk.consumer_key,
        consumer_secret: Odesk.consumer_secret,
        token: Odesk.oauth_token,
        token_secret: Odesk.oauth_token_secret,
        verifier: Odesk.verifier_token }
    end
  end
end
