# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rd/salesforce/version'

Gem::Specification.new do |spec|
  spec.name          = "rd-salesforce"
  spec.version       = Rd::Salesforce::VERSION
  spec.authors       = ["Jônatas Paganini"]
  spec.email         = ["jonatasdp@gmail.com"]
  spec.summary       = %q{Integrates Person with salesforce as a Lead.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
