# encoding: utf-8
require 'odesk/configuration'
require 'odesk/connection'
require 'odesk/oauth'
require 'odesk/client'
require 'odesk/resources/job'
require 'odesk/version'

# global Odesk object
module Odesk
  class << self
    def client
      @client = Odesk::Client.new unless defined?(@client)
      @client
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end

    private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end
