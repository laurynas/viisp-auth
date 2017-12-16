# frozen_string_literal: true

module VIISP
  module Auth
    class Configuration
      attr_accessor :pid
      attr_accessor :client_cert
      attr_accessor :client_private_key
      attr_accessor :service_cert
      attr_accessor :signature_algorithm
      attr_accessor :digest_algorithm

      def initialize
        @signature_algorithm = 'rsa-sha1'
        @digest_algorithm = 'sha1'
      end
    end
  end
end
