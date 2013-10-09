# encoding: utf-8
require_relative 'spec_helper'

describe Odesk do
  it 'should have a client' do
    Odesk.client.must_be_instance_of Odesk::Client
  end
end
