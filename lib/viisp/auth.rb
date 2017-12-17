require 'viisp/auth/version'
require 'viisp/auth/configuration'
require 'viisp/auth/errors'
require 'viisp/auth/client'
require 'viisp/auth/signing'
require 'viisp/auth/requests/soap'
require 'viisp/auth/requests/signature'
require 'viisp/auth/requests/ticket'

module VIISP
  module Auth
    module_function

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def client
      @client ||= Client.new
    end

    def ticket(options = {})
      request = Requests::Ticket.new(options).build
      signed_request = Signing.sign(request)

      response = client.post(signed_request)
      xml = Nokogiri::XML(response)

      Signing.validate!(xml)

      xml.remove_namespaces!
      xml.at('ticket')&.text
    end
  end
end
