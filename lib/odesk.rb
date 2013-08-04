require "odesk/configuration"
require "odesk/connection"
require "odesk/version"

module Odesk
  class << self
    include Configuration
    include Connection
  end
end
