# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money/version'

Gem::Specification.new do |spec|
  spec.name          = "investtools-money"
  spec.version       = Money::VERSION
  spec.authors       = ["André Aizim Kelmanson"]
  spec.email         = ["akelmanson@gmail.com"]
  spec.summary       = %q{A Ruby Library for dealing with money and currency conversion.}
  spec.description   = %q{A Ruby Library for dealing with money and currency conversion.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "terminal-notifier-guard"
end
