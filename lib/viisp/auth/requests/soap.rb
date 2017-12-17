# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      module Soap
        def soap_envelope(builder, namespaces)
          builder[:soapenv].Envelope(namespaces) do
            builder.Body { yield }
          end
        end
      end
    end
  end
end
