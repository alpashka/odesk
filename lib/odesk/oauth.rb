# encoding: utf-8

module Odesk
  # Methods to setup oauth request authentication
  module Oauth
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

    def authorize_request_params
      { oauth_callback: Odesk.callback_url,
        oauth_token: Odesk.oauth_token }
    end

    def validate_access_request!
      unless Odesk.oauth_token && Odesk.oauth_token_secret
        raise OauthError, 'Oauth token and secret requrired'
      end
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
  end
end
