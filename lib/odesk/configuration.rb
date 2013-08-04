module Odesk
  class InvalidConfigurationError < StandardError
  end

  module Configuration
    VALID_CONFIGURATION_KEYS = [
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret,
      :callback_url,
      :user_agent,
      :endpoint,
      :faraday_adapter
    ]

    attr_accessor *VALID_CONFIGURATION_KEYS

    def configure
      yield self
      self
      rescue
        raise InvalidConfigurationError
    end

    def endpoint
      @endpoint || "https://www.odesk.com"
    end

    def user_agent
      @user_agent || "Odesk gem v#{Odesk::VERSION}"
    end

    def faraday_adapter
      @faraday_adapter || :net_http
    end

    def reset_configuration
      VALID_CONFIGURATION_KEYS.each {|k| self.send("#{k}=", nil)}
    end
  end
end
