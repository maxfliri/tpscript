# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "tpscript"
  spec.version       = Tpscript::VERSION
  spec.authors       = ["Max Fliri"]
  spec.email         = ["mfliri@thoughtworks.com"]
  spec.summary       = %q{Scripts for TargetProcess}
  spec.description   = %q{Scripts for TargetProcess}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.required_ruby_version = "~> 2.1"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "httparty", "0.13.2"
end
