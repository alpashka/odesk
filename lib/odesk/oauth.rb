# encoding: utf-8

module Odesk
  # Methods to setup oauth request authentication
  module Oauth
    def authorize_url
      extract_tokens(connection.post '/api/auth/v1/oauth/token/request')
      querystring = URI.encode_www_form(authorize_request_params)
      "#{endpoint}/services/api/auth?#{querystring}"
    end

    def get_access_token(verifier)
      validate_access_request!
      self.verifier = verifier
      extract_tokens(connection.post '/api/auth/v1/oauth/token/access')
    end

    private

    def authorize_request_params
      { oauth_callback: callback_url,
        token: token }
    end

    def validate_access_request!
      unless token && token_secret
        fail OauthError, 'Oauth token and secret requrired'
      end
    end

    def extract_tokens(response)
      tokens = Hash[URI.decode_www_form(response.body)]
      save_tokens(tokens)
      tokens.reduce({}) { |memo, (k, v)| memo[k.to_sym] = v; memo }
    end

    def save_tokens(tokens)
      self.token = tokens['token']
      self.token_secret = tokens['token_secret']
    end
  end
end
