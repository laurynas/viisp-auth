# frozen_string_literal: true

require 'xmldsig'

module VIISP
  module Auth
    module Signing
      SCHEMAS_PATH = File.expand_path('../../../../schemas', __FILE__).freeze

      module_function

      def sign(doc, private_key = Auth.configuration.private_key)
        signed_document = Xmldsig::SignedDocument.new(doc, id_attr: 'id')
        signed_document.sign(private_key)
      end

      def validate!(doc, certificate = Auth.configuration.service_cert)
        Dir.chdir(SCHEMAS_PATH) do
          schema = IO.read('authentication.xsd')
          signed_document = Xmldsig::SignedDocument.new(doc, id_attr: 'id')
          # signed_document.validate(certificate, schema) ||
          #   raise(SignatureError, 'Unable to verify signature')
        end
      end
    end
  end
end
