require 'net/http'
require 'net/https'
require 'uri'

module GuruAPI
  # a simple Guru API client
  class Connection
    include GuruAPI::Configuration

    def initialize
      GuruAPI::Configuration.keys.each do |key|
        value = if options[key].nil?
                  GuruAPI.instance_variable_get(:"@#{key}")
                else
                  options[key]
                end

        instance_variable_set(:"@#{key}", value)
      end

      yield self if block_given?
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    def connect
      uri = URI.parse(@endpoint)
      session = Net::HTTP.new(uri.host, uri.port)
      session.use_ssl = true if uri.scheme == 'https'
      session.start do |conn|
        yield(conn)
      end
    end

    def request(method, path)
      log.info "#{method.to_s.upcase} #{path}..."
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
