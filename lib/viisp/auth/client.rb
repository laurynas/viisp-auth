# frozen_string_literal: true

require 'faraday'

module VIISP
  module Auth
    class Client
      def post(payload)
        with_error_handling do
          response = connection.post('', payload)
          response.body
        end
      end

      private

      def with_error_handling
        yield
      rescue Faraday::ClientError => e
        raise(RequestError, "#{e.message}. #{e.response}")
      end

      def connection
        @connection ||= Faraday.new(url: configuration.endpoint) do |builder|
          builder.options[:timeout] = configuration.read_timeout
          builder.options[:open_timeout] = configuration.open_timeout

          builder.headers['Accept'] = 'application/xml'

          builder.response :raise_error

          builder.adapter Faraday.default_adapter
        end
      end

      def configuration
        VIISP::Auth.configuration
      end
    end
  end
end
