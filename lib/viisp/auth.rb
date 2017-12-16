require 'viisp/auth/version'
require 'viisp/auth/configuration'
require 'viisp/auth/requests/soap'
require 'viisp/auth/requests/ticket'
require 'nokogiri-xmlsec'

module VIISP
  module Auth
    module_function

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
