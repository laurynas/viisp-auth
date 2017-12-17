# frozen_string_literal: true

require 'xmldsig'
require 'nokogiri'

module VIISP
  module Auth
    module Requests
      class Ticket
        include Soap
        include Signature

        NAMESPACES = {
          'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
          'xmlns:authentication' => 'http://www.epaslaugos.lt/services/authentication',
          'xmlns:ds' => 'http://www.w3.org/2000/09/xmldsig#',
        }.freeze

        NODE_ID = 'uniqueNodeId'

        def initialize(pid: nil, providers: nil, attributes: nil, user_information: nil,
                       postback_url: nil, custom_data: '')
          @pid = pid || configuration.pid
          @providers = providers || configuration.providers
          @attributes = attributes || configuration.attributes
          @user_information = user_information || configuration.user_information
          @postback_url = postback_url || configuration.postback_url
          @custom_data = custom_data
        end

        def build
          builder = Nokogiri::XML::Builder.new do |builder|
            soap_envelope(builder, NAMESPACES) do
              build_request(builder)
            end
          end

          builder.doc
        end

        private

        def build_request(builder)
          builder[:authentication].authenticationRequest(id: NODE_ID) do
            builder.pid(@pid)

            @providers.each do |provider|
              builder.authenticationProvider(provider)
            end

            @attributes.each do |attribute|
              builder.authenticationAttribute(attribute)
            end

            @user_information.each do |val|
              builder.userInformation(val)
            end

            builder.postbackUrl(@postback_url)
            builder.customData(@custom_data)

            build_signature(builder, NODE_ID)
          end
        end

        def configuration
          Auth.configuration
        end
      end
    end
  end
end
