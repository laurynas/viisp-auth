# frozen_string_literal: true

module VIISP
  module Auth
    class Error < StandardError; end
    class RequestError < Error; end
    class SignatureError < Error; end
    class ConfigurationError < Error; end
  end
end
