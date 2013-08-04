require_relative '../spec_helper'

describe Odesk::Configuration do
  before do
    Odesk.configure do |config|
      config.consumer_key = "test"
    end
  end

  it 'should accept configuration block' do
    Odesk.consumer_key.must_equal "test"
  end

  it 'should not accept invalid configuration keys' do
    proc {
      Odesk.configure do |config|
        config.bad_option = "test"
      end
    }.must_raise Odesk::InvalidConfigurationError
  end

  it 'should have a default set for the endpoint' do
    Odesk.endpoint.must_equal "https://www.odesk.com"
  end
  
  it 'should have a default set for the useragent' do
    Odesk.user_agent.must_equal "Odesk gem v#{Odesk::VERSION}"
  end
  
  it 'should allow defaults be overridden' do
    Odesk.configure do |config|
      config.user_agent = "Custom User Agent"
    end
    Odesk.user_agent.must_equal "Custom User Agent"
  end
end
