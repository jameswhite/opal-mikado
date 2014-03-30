# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opal/mikado/version'

Gem::Specification.new do |spec|
  spec.name          = "opal-mikado"
  spec.version       = Opal::Mikado::VERSION
  spec.authors       = ["Eric West"]
  spec.email         = ["eric.west@lonelyplanet.com"]
  spec.summary       = %q{Uses dagre-d3 to build a graph of tasks and dependencies.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'opal', ['>= 0.5.0', '< 1.0.0']
  spec.add_dependency 'opal-browser'
  spec.add_dependency 'opal-dagred3'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency 'opal-rspec', '~> 0.3.0'
  spec.add_development_dependency 'pry'
end
