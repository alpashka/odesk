# encoding: utf-8
require_relative '../spec_helper'

def request_response
  'oauth_callback_confirmed=true' +
  '&oauth_token=test_oauth_token' +
  '&oauth_token_secret=test_oauth_token_secret'
end

def access_response
  'oauth_token=access_token' +
  '&oauth_token_secret=access_token_secret'
end

def build_stubs
  Faraday::Adapter::Test::Stubs.new do |stub|
    stub.post('/api/auth/v1/oauth/token/request') do
      [200, {}, request_response]
    end
    stub.post('/api/auth/v1/oauth/token/access') do
      [200, {}, access_response]
    end
  end
end

def set_odesk_configuration
  Odesk.configure do |config|
    config.consumer_key    = 'test_consumer_key'
    config.consumer_secret = 'test_consumer_secret'
    config.callback_url    = 'http://localhost:3000/oauth/callback'
    config.faraday_adapter = :test, build_stubs
  end
end

describe Odesk::Oauth do
  before do
    set_odesk_configuration
  end

  it 'should have the oauth consumer tokens set' do
    @oauth_options = Odesk.connection.app.instance_variable_get '@options'
    @oauth_options[:consumer_key].must_equal 'test_consumer_key'
    @oauth_options[:consumer_secret].must_equal 'test_consumer_secret'
  end

  it 'should raise an error if the consumer key is not set' do
    proc {
      Odesk.consumer_key = nil
      Odesk.connection
    }.must_raise Odesk::InvalidConfigurationError
  end

  it 'should raise an error if the consumer secret is not set' do
    proc {
      Odesk.consumer_secret = nil
      Odesk.connection
    }.must_raise Odesk::InvalidConfigurationError
  end

  describe 'when calling authorise_url' do
    before do
      @authorize_url = Odesk.authorize_url
    end

    it 'should set the oauth_token' do
      Odesk.oauth_token.must_equal 'test_oauth_token'
    end

    it 'should set the oauth_token_secret' do
      Odesk.oauth_token_secret.must_equal 'test_oauth_token_secret'
    end

    it 'should encode the correct params in the auth url' do
      url = 'https://www.odesk.com/services/api/auth?' +
            'oauth_callback=http%3A%2F%2Flocalhost%3A3000%2Foauth%2Fcallback' +
            '&oauth_token=test_oauth_token'
      @authorize_url.must_equal url
    end

    it 'should also reset the oauth options for the oauth middleware' do
      @oauth_options = Odesk.connection.app.instance_variable_get '@options'
      @oauth_options[:token].must_equal 'test_oauth_token'
      @oauth_options[:token_secret].must_equal 'test_oauth_token_secret'
    end
  end

  describe 'when getting an access token' do
    it 'should raise an error if the oauth tokens are not set' do
      proc {
        Odesk.oauth_token = nil
        Odesk.get_access_token('verify_token')
      }.must_raise Odesk::OauthError
    end

    describe 'with correct config' do
      before do
        Odesk.oauth_token = 'test_oauth_token'
        @access_tokens = Odesk.get_access_token('verifier_token')
      end

      it 'should set the verifier token' do
        oauth_options = Odesk.connection.app.instance_variable_get '@options'
        oauth_options[:verifier].must_equal 'verifier_token'
      end

      it 'should reset the oauth tokens with the new access token details' do
        Odesk.oauth_token.must_equal 'access_token'
        Odesk.oauth_token_secret.must_equal 'access_token_secret'
      end

      it 'should return a hash of the access tokens' do
        @access_tokens[:oauth_token].must_equal Odesk.oauth_token
        @access_tokens[:oauth_token_secret].must_equal Odesk.oauth_token_secret
      end
    end
  end
end
