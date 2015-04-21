# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fetch_app/version'

Gem::Specification.new do |spec|
  spec.name          = "fetch_app"
  spec.version       = FetchApp::VERSION
  spec.authors       = ["Will"]
  spec.email         = ["yh@fir.im"]
  spec.summary       = %q{one gem fetch app.}
  spec.description   = %q{one gem to fetch app.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency 'rest-client', '~> 1.8.0', '>= 1.1.4'
end
