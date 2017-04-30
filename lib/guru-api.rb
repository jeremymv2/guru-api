require 'json'
require 'net/http'
require 'logify'

require 'guru-api/version'
require 'guru-api/resource'
require 'guru-api/connection'

include Logify

# do not inflate JSON objects
JSON.create_id = nil

module GuruAPI

  UNSET = Object.new

  class << self
    def connection
      unless @connection
        @connection = GuruAPI::Connection.new
      end

      @connection
    end

    #
    # Delegate all methods to the connection object, essentially making the
    # module object behave like a {Connection}.
    #
    def method_missing(m, *args, &block)
      if connection.respond_to?(m)
        connection.send(m, *args, &block)
      else
        super
      end
    end

    #
    # Delegating +respond_to+ to the {Connection}.
    #
    def respond_to_missing?(m, include_private = false)
      connection.respond_to?(m) || super
    end
  end
end
