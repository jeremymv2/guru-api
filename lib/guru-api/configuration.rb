module GuruAPI
  #
  module Configuration
    class << self
      def keys
        @keys ||= [
          :endpoint,
          :api_version,
          :user,
          :pass,
          :ssl_verify
        ]
      end
    end

    GuruAPI::Configuration.keys.each do |key|
      attr_accessor key
    end

    def configure
      yield self
    end

    def reset!
      GuruAPI::Configuration.keys.each do |key|
        instance_variable_set(:"@#{key}", Defaults.options[key])
      end
      self
    end
    alias setup reset!

    private

    def options
      map = GuruAPI::Configuration.keys.map do |key|
        [key, instance_variable_get(:"@#{key}")]
      end
      Hash[map]
    end
  end
end
