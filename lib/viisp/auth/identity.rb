# frozen_string_literal: true

module VIISP
  module Auth
    class Identity
      attr_reader :doc

      def initialize(doc)
        @doc = doc
      end

      def to_hash
        {
          'authentication_provider' => element_text('authenticationProvider'),
          'attributes' => attributes,
          'user_information' => user_information,
          'custom_data' => element_text('customData'),
          'source_data' => source_data,
        }
      end

      private

      def attributes
        pairs = doc.css('authenticationAttribute').map do |el|
          [el.at('attribute').text, el.at('value').text]
        end

        Hash[pairs]
      end

      def user_information
        pairs = doc.css('userInformation').map do |el|
          value = el.at('stringValue')&.text || el.at('dateValue')&.text
          [el.at('information').text, value]
        end

        Hash[pairs]
      end

      def source_data
        return unless source_data_element

        {
          'type' => source_data_element.at('type').text,
          'parameters' => source_data_parameters,
        }
      end

      def source_data_element
        @source_data_element ||= doc.at('sourceData')
      end

      def source_data_parameters
        pairs = source_data_element.css('parameter').map do |el|
          [el.attr('name'), el.text]
        end

        Hash[pairs]
      end

      def element_text(element_name)
        doc.at(element_name)&.text
      end
    end
  end
end
