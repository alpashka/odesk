# encoding: utf-8
require 'faraday'
require 'faraday_middleware'

module Odesk
  class OauthError < StandardError
  end

  # Handles the Faraday connection to oDesk
  module Connection
    def connection
      validate_configuration!

      Faraday.new(Odesk.endpoint, faraday_options) do |conn|
        conn.request :oauth, oauth_options
        conn.request :url_encoded
        conn.adapter *Odesk.faraday_adapter
      end
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

    def faraday_options
      { headers: {
          user_agent: Odesk.user_agent
        } }
    end

    def oauth_options
      [:consumer_key, :consumer_secret, :token, :token_secret,
        :verifier].reduce({}){ |opts,k| opts[k] = Odesk.send(k); opts }
    end
  end
end
