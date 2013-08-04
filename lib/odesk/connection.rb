require 'faraday'

module Odesk
  module Connection
    def connection
      Faraday.new(Odesk.endpoint,{
        :headers => {
          :user_agent => Odesk.user_agent
        }
      }) do |conn|
        conn.adapter Odesk.faraday_adapter
      end
    end
  end
end
