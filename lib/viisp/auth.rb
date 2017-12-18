require 'nokogiri'
require 'viisp/auth/version'
require 'viisp/auth/configuration'
require 'viisp/auth/errors'
require 'viisp/auth/client'
require 'viisp/auth/signing'
require 'viisp/auth/identity'
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

      doc = client.post(request)
      doc.remove_namespaces!
      doc.at('ticket')&.text
    end

    def identity(options = {})
      request = Requests::Identity.new(options).build

      doc = client.post(request)
      doc.remove_namespaces!

      Identity.new(doc).to_hash
    end
  end
end
