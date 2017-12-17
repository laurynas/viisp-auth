# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      module Soap
        module_function

        def build(body)
          <<~XML
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
              <soapenv:Header/>
              <soapenv:Body>          
                #{body}           
              </soapenv:Body>
            </soapenv:Envelope>
          XML
        end
      end
    end
  end
end
