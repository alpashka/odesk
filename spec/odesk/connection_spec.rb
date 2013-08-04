require_relative '../spec_helper'

describe Odesk::Connection do
  before do
    @connection = Odesk.connection
  end
  
  it 'should return a new Faraday connection' do
    @connection.must_be_instance_of Faraday::Connection
  end
  
end
