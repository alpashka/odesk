# encoding: utf-8
module Odesk
  # Client class for making calls to the api
  class Client
    include Configuration
    include Connection
    include Oauth
  end
end
