require 'bundler/setup'
require 'viisp/auth'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    VIISP::Auth.configure do |c|
      c.test = true
      c.postback_url = 'https://localhost'
      # c.private_key = OpenSSL::PKey::RSA.new(fixture('testKey.pem'))
    end
  end
end
