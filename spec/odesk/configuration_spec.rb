# encoding: utf-8
require_relative '../spec_helper'

describe Odesk::Configuration do
  before do
    @client = Odesk::Client.new do |config|
      config.consumer_key = 'test'
    end
  end

  it 'should accept configuration block' do
    @client.consumer_key.must_equal 'test'
  end

  it 'should also accept configuration via a hash' do
    config = { consumer_key: 'consumer_key' }
    @hsh_client = Odesk::Client.new(config)
    @hsh_client.consumer_key.must_equal 'consumer_key'
  end

  it 'should not accept invalid configuration keys' do
    proc do
      Odesk::Client.new do |config|
        config.bad_option = 'test'
      end
    end.must_raise Odesk::InvalidConfigurationError
  end

  it 'should have a default set for the endpoint' do
    @client.endpoint.must_equal 'https://www.odesk.com'
  end

  it 'should have a default set for the user agent' do
    @client.user_agent.must_equal "Odesk gem v#{Odesk::VERSION}"
  end

  it 'should allow defaults be overridden' do
    @custom = Odesk::Client.new do |config|
      config.user_agent = 'Custom User Agent'
    end
    @custom.user_agent.must_equal 'Custom User Agent'
  end
end
