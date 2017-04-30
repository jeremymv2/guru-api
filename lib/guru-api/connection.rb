require 'net/http'
require 'net/https'
require 'uri'

module GuruAPI
  # a simple Guru API client
  class Connection

    include GuruAPI::Configuration

    API_VERSION = 'v1'

    def initialize(user = nil, pass = nil, endpoint = nil)
      @user = user || ENV['guru-user']
      @pass = pass || ENV['guru-token']
      @endpoint = endpoint || 'https://api.getguru.com'
    end

    def get(path, params = {}, request_options = {})
      request(:get, path, params)
    end

    def connect
      uri = URI.parse(@endpoint)
      session = Net::HTTP.new(uri.host, uri.port)
      if 'https' == uri.scheme
        session.use_ssl = true
      end
      session.start do |conn|
        yield(conn)
      end
    end

    def request(method, path, params = {})
      log.info  "#{method.to_s.upcase} #{path}..."
      puts "#{method.to_s.upcase} #{path}..."
      resp_obj = nil
      connect do |conn|
        req = Net::HTTP.const_get(method.to_s.capitalize).new(path)
        req.basic_auth(@user, @pass)
        # req.set_form_data query
        resp = conn.request(req)
        begin
          resp_obj = JSON.parse(resp.body)
        rescue => ex
          raise "Invalid JSON Response: #{ex}"
        end
      end
      resp_obj
    end
  end
end
