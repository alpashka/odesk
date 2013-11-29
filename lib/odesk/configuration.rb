# encoding: utf-8
module Odesk
  class InvalidConfigurationError < StandardError
  end

  # Odesk gem configuration (mostly oauth tokens)
  module Configuration
    VALID_CONFIGURATION_KEYS = [
      :consumer_key,
      :consumer_secret,
      :token,
      :token_secret,
      :verifier,
      :callback_url,
      :user_agent,
      :endpoint,
      :faraday_adapter
    ]

    attr_accessor *VALID_CONFIGURATION_KEYS

    def configure(config = nil)
      load_hash_config(config) if config
      yield self if block_given?
      self
      rescue => error
        raise InvalidConfigurationError, error.message
    end
    alias_method :initialize, :configure

    def endpoint
      @endpoint || 'https://www.odesk.com'
    end

    def user_agent
      @user_agent || "Odesk gem v#{Odesk::VERSION}"
    end

    def faraday_adapter
      @faraday_adapter || :net_http
    end

    def reset_configuration
      VALID_CONFIGURATION_KEYS.each { |k| send("#{k}=", nil) }
    end

    private

    def load_hash_config(config)
      config.each { |attr, value| send("#{attr}=", value) }
    end
  end
end
