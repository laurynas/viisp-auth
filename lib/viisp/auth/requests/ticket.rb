# frozen_string_literal: true

require 'xmldsig'
require 'nokogiri'

module VIISP
  module Auth
    module Requests
      module Ticket
        NAMESPACES = {
          'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
          'xmlns:authentication' => 'http://www.epaslaugos.lt/services/authentication',
          'xmlns:ds' => 'http://www.w3.org/2000/09/xmldsig#',
        }.freeze

        NODE_ID = 'uniqueNodeId'

        module_function

        def build(
          pid: configuration.pid,
          providers: configuration.providers,
          attributes: configuration.attributes,
          user_information: configuration.user_information,
          postback_url: configuration.postback_url,
          custom_data: ''
        )
          builder = Nokogiri::XML::Builder.new

          builder[:soapenv].Envelope(NAMESPACES) do
            builder.Body do
              builder[:authentication].authenticationRequest(id: NODE_ID) do
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

                builder[:ds].Signature do
                  builder.SignedInfo do
                    builder.CanonicalizationMethod(Algorithm: 'http://www.w3.org/2001/10/xml-exc-c14n#')
                    builder.SignatureMethod(Algorithm: 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256')
                    builder.Reference(URI: '#' + NODE_ID) do
                      builder.Transforms do
                        builder.Transform(Algorithm: 'http://www.w3.org/2000/09/xmldsig#enveloped-signature')
                        builder.Transform(Algorithm: 'http://www.w3.org/2001/10/xml-exc-c14n#')
                      end
                      builder.DigestMethod(Algorithm: 'http://www.w3.org/2001/04/xmlenc#sha256')
                      builder.DigestValue
                    end
                  end
                  builder.SignatureValue
                end
              end
            end
          end

          signed_document = Xmldsig::SignedDocument.new(builder.doc, id_attr: 'id')
          signed_document.sign(private_key)
        end

        def private_key
          OpenSSL::PKey::RSA.new(configuration.client_private_key)
        end

        def configuration
          VIISP::Auth.configuration
        end
      end
    end
  end
end
