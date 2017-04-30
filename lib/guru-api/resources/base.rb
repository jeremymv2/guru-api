module GuruAPI
  class Resource::Base
    class << self
      include Enumerable
    def initialize(options = {})
      # Use any options given, but fall back to the defaults set on the module
      options.keys.each do |key|
        value = if options[key].nil?
          GuruAPI.instance_variable_get(:"@#{key}")
        else
          options[key]
        end

        instance_variable_set(:"@#{key}", value)
      end

      yield self if block_given?
    end

    def build_path(args = {})
      base = "/api/#{GuruAPI::Connection::API_VERSION}"
      case args[:caller]
      when 'fetch'
        "#{base}#{@resource_path.gsub(/<id>/, args[:id].to_s)}"
      when 'list'
        "#{base}#{@list_path}"
      end
    end

    def list(search = nil)
      path = build_path(q: search, caller: 'list')
      response = connection.get(path)
    rescue => ex
      log.error ex.to_s
      nil
    end

    def fetch(id)
      return nil if id.nil?

      path = build_path(id: id, caller: 'fetch')
      response = connection.get(path)
    rescue => ex
      log.error ex.to_s
      nil
    end

    def connection
      GuruAPI.connection
    end

    def list_path(value = nil)
      if !value.nil?
        @list_path = value.to_s
      else
        @list_path ||
          raise(ArgumentError, "list_path not set for #{self.class}")
      end
    end

    def resource_path(value = nil)
      if !value.nil?
        @resource_path = value.to_s
      else
        @resource_path ||
          raise(ArgumentError, "resource_path not set for #{self.class}")
      end
    end
  end
  end
end
