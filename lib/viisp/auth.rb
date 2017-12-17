require 'nokogiri'
require 'viisp/auth/version'
require 'viisp/auth/configuration'
require 'viisp/auth/errors'
require 'viisp/auth/client'
require 'viisp/auth/signing'
require 'viisp/auth/requests/soap'
require 'viisp/auth/requests/signature'
require 'viisp/auth/requests/ticket'
require 'viisp/auth/requests/identity'

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

    def portal_endpoint
      configuration.portal_endpoint
    end

    def ticket(options = {})
      request = Requests::Ticket.new(options).build
      xml = client.post(request)
      xml.remove_namespaces!
      xml.at('ticket')&.text
    end

    def identity(options = {})
      request = Requests::Identity.new(options).build
      xml = client.post(request)

    end
  end
end
