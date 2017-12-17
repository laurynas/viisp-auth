lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'viisp/auth/version'

Gem::Specification.new do |spec|
  spec.name = 'viisp-auth'
  spec.version = VIISP::Auth::VERSION
  spec.authors = ['Laurynas Butkus']
  spec.email = ['laurynas.butkus@gmail.com']

  spec.summary = 'VIISP authentication client'
  spec.homepage = 'https://github.com/laurynas/viisp-auth'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'xmldsig', '~> 0.6'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
