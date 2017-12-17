# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      module Soap
        NAMESPACES = {
          'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
          'xmlns:authentication' => 'http://www.epaslaugos.lt/services/authentication',
          'xmlns:ds' => 'http://www.w3.org/2000/09/xmldsig#',
        }.freeze

        def soap_envelope(builder)
          builder[:soapenv].Envelope(NAMESPACES) do
            builder.Body { yield }
          end
        end
      end
    end
  end
end
