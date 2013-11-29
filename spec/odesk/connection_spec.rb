# encoding: utf-8
require_relative '../spec_helper'

describe Odesk::Connection do
  before do
    @client = Odesk::Client.new do |config|
      config.consumer_key    = 'bia6i6yiaylufoeswia77iujlunoacrl'
      config.consumer_secret = 'prouw9iasiuwleyl'
      config.callback_url    = 'http://localhost:3000/oauth/callback'
    end
    @connection = @client.connection
  end

  it 'should return a new Faraday connection' do
    @connection.must_be_instance_of Faraday::Connection
  end

  it 'should have the host for all requests set' do
    @connection.url_prefix.must_equal URI.parse(@client.endpoint)
  end

  it 'should have the user agent set' do
    @connection.headers[:user_agent].must_equal @client.user_agent
  end

  it 'should use the faraday oauth middleware' do
    @connection.builder[0].klass.must_equal FaradayMiddleware::OAuth
  end
end
