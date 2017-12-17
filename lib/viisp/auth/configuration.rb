# frozen_string_literal: true

module VIISP
  module Auth
    class Configuration
      CERTS_PATH = File.expand_path('../../../../certs', __FILE__).freeze

      DEFAULT_PROVIDERS = %w[
        auth.lt.identity.card
        auth.lt.bank
        auth.signatureProvider
        auth.login.pass
        auth.lt.government.employee.card
        auth.stork
        auth.tsl.identity.card
      ].freeze

      DEFAULT_ATTRIBUTES = %w[
        lt-personal-code
        lt-company-code
      ].freeze

      DEFAULT_USER_INFORMATION = %w[
        firstName
        lastName
        companyName
        email
      ].freeze

      PRODUCTION_ENDPOINT = 'https://www.epaslaugos.lt/portal/authenticationServices/auth'
      PRODUCTION_PORTAL_ENDPOINT = 'https://www.epaslaugos.lt/portal/external/services/authentication/v2/'

      TEST_PID = 'VSID000000000113'
      TEST_ENDPOINT = 'https://www.epaslaugos.lt/portal-test/services/AuthenticationServiceProxy'
      TEST_PORTAL_ENDPOINT = 'https://www.epaslaugos.lt/portal-test/external/services/authentication/v2/'

      DEFAULT_OPEN_TIMEOUT = 3
      DEFAULT_READ_TIMEOUT = 10

      attr_writer :pid
      attr_writer :postback_url
      attr_writer :test
      attr_writer :endpoint
      attr_writer :portal_endpoint
      attr_writer :private_key
      attr_writer :service_cert

      attr_accessor :providers
      attr_accessor :attributes
      attr_accessor :user_information

      attr_accessor :read_timeout
      attr_accessor :open_timeout

      def initialize
        @providers = DEFAULT_PROVIDERS
        @attributes = DEFAULT_ATTRIBUTES
        @user_information = DEFAULT_USER_INFORMATION

        @open_timeout = DEFAULT_OPEN_TIMEOUT
        @read_timeout = DEFAULT_READ_TIMEOUT
      end

      def pid
        return @pid if @pid
        return TEST_PID if test?
        error('pid not configured')
      end

      def postback_url
        @postback_url || error('postback_url not configured')
      end

      def endpoint
        return @endpoint if @endpoint
        return TEST_ENDPOINT if test?
        PRODUCTION_ENDPOINT
      end

      def portal_endpoint
        return @portal_endpoint if @portal_endpoint
        return TEST_PORTAL_ENDPOINT if test?
        PRODUCTION_PORTAL_ENDPOINT
      end

      def private_key
        return @private_key if @private_key
        return test_private_key if test?
        error('private key not configured')
      end

      def service_cert
        @service_cert || builtin_service_cert
      end

      def test?
        @test
      end

      private

      def builtin_service_cert
        @builtin_service_cert ||= OpenSSL::X509::Certificate.new(
          read_cert('epaslaugos_ident.crt')
        )
      end

      def test_private_key
        @test_private_key ||= OpenSSL::PKey::RSA.new(
          read_cert('testKey.pem')
        )
      end

      def read_cert(filename)
        path = File.join(CERTS_PATH, filename)
        File.read(path)
      end

      def error(message)
        raise(ConfigurationError, message)
      end
    end
  end
end
