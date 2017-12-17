# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      class Identity
        include Soap
        include Signature

        NODE_ID = 'uniqueNodeId'

        def initialize(ticket:, include_source_data: false)
          @ticket = ticket
          @include_source_data = include_source_data
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
          builder[:authentication].authenticationDataRequest(id: NODE_ID) do
            builder.pid(configuration.pid)
            builder.ticket(@ticket)
            builder.includeSourceData('true') if @include_source_data

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
