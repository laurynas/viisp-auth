# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      module Soap
        module_function

        def build(body)
          <<~TEXT
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                    xmlns:aut="http://www.epaslaugos.lt/services/authentication"
                    xmlns:xd="http://www.w3.org/2000/09/xmldsig#">
              <soapenv:Header/>
              <soapenv:Body>
                #{body}
              </soapenv:Body>
            </soapenv:Envelope>
          TEXT
        end
      end
    end
  end
end
