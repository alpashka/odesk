require_relative '../spec_helper'

describe Odesk::Connection do
  before do
    @connection = Odesk.connection
  end
  
  it 'should return a new Faraday connection' do
    @connection.must_be_instance_of Faraday::Connection
  end
  
  it 'should have the host for all requests set' do
    @connection.url_prefix.must_equal URI.parse(Odesk.endpoint)
  end
  
  it 'should have the user agent set' do
    @connection.headers[:user_agent].must_equal Odesk.user_agent
  end
  
end
