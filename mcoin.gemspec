# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mcoin/version'

Gem::Specification.new do |spec|
  spec.name          = 'mcoin'
  spec.version       = Mcoin::VERSION
  spec.authors       = ['蒼時弦也']
  spec.email         = ['contact@frost.tw']

  spec.summary       = 'The BTC market monitor tool'
  spec.description   = 'The BTC market monitor tool'
  spec.homepage      = 'https://github.com/elct9620/mcoin'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
