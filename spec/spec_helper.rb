require 'bundler/setup'
require 'viisp/auth'
require_relative 'support/fixture_helpers'

RSpec.configure do |config|
  config.include(FixtureHelpers)

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    VIISP::Auth.configure do |c|
      c.client_cert = fixture('testCert.pem')
      c.client_private_key = fixture('testKey.pem')
    end
  end
end
