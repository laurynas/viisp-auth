# frozen_string_literal: true

module VIISP
  module Auth
    module Requests
      module Signature
        def build_signature(builder, element_id)
          builder[:ds].Signature do
            builder.SignedInfo do
              builder.CanonicalizationMethod(Algorithm: 'http://www.w3.org/2001/10/xml-exc-c14n#')
              builder.SignatureMethod(Algorithm: 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256')
              builder.Reference(URI: '#' + element_id) do
                builder.Transforms do
                  builder.Transform(Algorithm: 'http://www.w3.org/2000/09/xmldsig#enveloped-signature')
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
  end
end
