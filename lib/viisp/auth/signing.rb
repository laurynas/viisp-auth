# frozen_string_literal: true

module VIISP
  module Auth
    module Signing
      module_function

      def sign(doc, private_key = Auth.configuration.private_key)
        signed_document = Xmldsig::SignedDocument.new(doc, id_attr: 'id')
        signed_document.sign(private_key)
      end
    end
  end
end
