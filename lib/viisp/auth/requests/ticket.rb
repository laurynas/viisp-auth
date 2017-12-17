# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      class Ticket
        include Soap
        include Signature

        NODE_ID = 'uniqueNodeId'

        def initialize(providers: nil, attributes: nil, user_information: nil, postback_url: nil,
                       custom_data: '')
          @providers = providers || configuration.providers
          @attributes = attributes || configuration.attributes
          @user_information = user_information || configuration.user_information
          @postback_url = postback_url || configuration.postback_url
          @custom_data = custom_data
        end

        def build
          builder = Nokogiri::XML::Builder.new do |builder|
            soap_envelope(builder) do
              build_request(builder)
            end
          end

          builder.doc
        end

        private

        def build_request(builder)
          builder[:authentication].authenticationRequest(id: NODE_ID) do
            builder.pid(configuration.pid)

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
