require 'viisp/auth/version'
require 'viisp/auth/configuration'
require 'viisp/auth/client'
require 'viisp/auth/requests/soap'
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
      request = Requests::Ticket.build(options)
      response = client.post(request)

      xml = Nokogiri::XML(response).remove_namespaces!
      xml.at('ticket')&.text
    end
  end
end
