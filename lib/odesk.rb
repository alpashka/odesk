# encoding: utf-8
require 'odesk/configuration'
require 'odesk/connection'
require 'odesk/oauth'
require 'odesk/version'

# global Odesk object
module Odesk
  class << self
    include Configuration
    include Connection
    include Oauth
  end
end
