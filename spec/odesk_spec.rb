# encoding: utf-8
require_relative 'spec_helper'

describe Odesk do
  it 'should have a client' do
    Odesk.client.must_be_instance_of Odesk::Client
  end

  it 'should proxy method calls to client' do
    client = Odesk::Client.new
    client.public_methods.each do |m|
      assert Odesk.respond_to?(m)
    end
  end
end
