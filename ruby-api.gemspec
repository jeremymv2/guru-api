# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guru-api/version'

Gem::Specification.new do |spec|
  spec.name          = 'guru-api'
  spec.version       = GuruAPI::VERSION
  spec.authors       = ['Jeremy Miller']
  spec.email         = ['jeremymv2@gmail.com']
  spec.description   = 'A tiny Guru API client'
  spec.summary       = 'A Guru API client in Ruby'
  spec.homepage      = 'https://github.com/jeremymv2/guru-api'
  spec.license       = 'Apache 2.0'

  spec.required_ruby_version = '>= 2.1'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'logify',     '~> 0.1'
  spec.add_dependency 'mime-types'
end
