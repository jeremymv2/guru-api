require 'json'
require 'net/http'
require 'logify'
require 'guru-api/version'

include Logify

# do not inflate JSON objects
JSON.create_id = nil

module GuruAPI
  autoload :Configuration,  'guru-api/configuration'
  autoload :Resource,       'guru-api/resource'
  autoload :Connection,     'guru-api/connection'

  UNSET = Object.new

  class << self
    def connection
      unless @connection
        @connection = GuruAPI::Connection.new
      end

      @connection
    end

    def method_missing(m, *args, &block)
      if connection.respond_to?(m)
        connection.send(m, *args, &block)
      else
        super
      end
    end

    #
    def respond_to_missing?(m, include_private = false)
      connection.respond_to?(m) || super
    end
  end
end
