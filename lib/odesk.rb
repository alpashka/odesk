# encoding: utf-8
require 'odesk/configuration'
require 'odesk/connection'
require 'odesk/version'

# global Odesk object
module Odesk
  class << self
    include Configuration
    include Connection
  end
end
