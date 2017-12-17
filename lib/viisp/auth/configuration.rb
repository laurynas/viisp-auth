# frozen_string_literal: true

module VIISP
  module Auth
    class Configuration
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
      ]

      PRODUCTION_ENDPOINT = 'https://www.epaslaugos.lt/portal/authenticationServices/auth'
      PRODUCTION_PORTAL_ENDPOINT = 'https://www.epaslaugos.lt/portal/external/services/authentication/v2/'

      TEST_ENDPOINT = 'https://www.epaslaugos.lt/portal-test/services/AuthenticationServiceProxy'
      TEST_PORTAL_ENDPOINT = 'https://www.epaslaugos.lt/portal-test/external/services/authentication/v2/'

      DEFAULT_OPEN_TIMEOUT = 3
      DEFAULT_READ_TIMEOUT = 10

      attr_writer :test
      attr_writer :endpoint
      attr_writer :portal_endpoint

      attr_writer :pid
      attr_writer :postback_url

      attr_accessor :providers
      attr_accessor :attributes
      attr_accessor :user_information

      attr_accessor :client_cert
      attr_accessor :client_private_key
      attr_accessor :service_cert

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
        @pid || raise('pid not configured')
      end

      def postback_url
        @postback_url || raise('postback_url not configured')
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

      def test?
        @test
      end
    end
  end
end
