require 'faraday'
require 'faraday_middleware'

module Odesk
  class OauthError < StandardError
  end

  module Connection
    def connection
      unless Odesk.consumer_key
        raise InvalidConfigurationError, "The consumer key is not set"
      end

      unless Odesk.consumer_secret
        raise InvalidConfigurationError, "The consumer secret is not set"
      end

      Faraday.new(Odesk.endpoint,{
        :headers => {
          :user_agent => Odesk.user_agent
        }
      }) do |conn|
        conn.request :oauth, oauth_options
        conn.request :url_encoded
        conn.adapter *Odesk.faraday_adapter
      end
    end

    def authorize_url
      extract_tokens(connection.post '/api/auth/v1/oauth/token/request')
      "https://www.odesk.com/services/api/auth?#{URI.encode_www_form("oauth_callback" => Odesk.callback_url, "oauth_token" => Odesk.oauth_token)}"
    end

    def get_access_token(verifier_token)
      unless Odesk.oauth_token && Odesk.oauth_token_secret
        raise OauthError, "The oauth token and secret need to be set before obtaining an access token"
      end
      Odesk.verifier_token = verifier_token
      tokens = extract_tokens(connection.post '/api/auth/v1/oauth/token/access')
    end

    private

    def extract_tokens(response)
      tokens = Hash[URI.decode_www_form(response.body)]
      Odesk.oauth_token = tokens['oauth_token']
      Odesk.oauth_token_secret = tokens['oauth_token_secret']
      tokens.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end

    def oauth_options
      opts = {:consumer_key => Odesk.consumer_key, :consumer_secret => Odesk.consumer_secret}
      opts[:token] = Odesk.oauth_token if Odesk.oauth_token
      opts[:token_secret] = Odesk.oauth_token_secret if Odesk.oauth_token_secret
      opts[:verifier] = Odesk.verifier_token if Odesk.verifier_token
      opts
    end

  end
end
