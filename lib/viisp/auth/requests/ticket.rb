# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      module Ticket
        NAMESPACES = {
          'xmlns:authentication' => 'http://www.epaslaugos.lt/services/authentication',
          'xmlns:dsig' => 'http://www.w3.org/2000/09/xmldsig#',
          'xmlns:ns3' => 'http://www.w3.org/2001/10/xml-exc-c14n#',
        }.freeze

        module_function

        def build(pid:, providers:, attributes:, user_information:, postback_url:, custom_data:)
          builder = Nokogiri::XML::Builder.new

          builder[:authentication].authenticationRequest(NAMESPACES) do
            builder.pid(pid)

            providers.each do |provider|
              builder.authenticationProvider(provider)
            end

            attributes.each do |attribute|
              builder.authenticationAttribute(attribute)
            end

            user_information.each do |val|
              builder.userInformation(val)
            end

            builder.postbackUrl(postback_url)
            builder.customData(custom_data)
          end

          builder.doc.sign!(signing_options)

          Requests::Soap.build(builder.doc.root.to_xml)
        end

        def signing_options
          {
            cert: configuration.client_cert,
            key: configuration.client_private_key,
            signature_alg: configuration.signature_algorithm,
            digest_alg: configuration.digest_algorithm,
          }
        end

        def configuration
          VIISP::Auth.configuration
        end
      end
    end
  end
end
