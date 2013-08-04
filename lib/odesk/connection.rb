require 'faraday'

module Odesk
  module Connection
    def connection
      Faraday.new("http://localhost", {})  
    end
  end
end
