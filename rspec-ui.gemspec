# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/ui/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-ui"
  spec.version       = Rspec::Ui::VERSION
  spec.authors       = ["Chris Teague"]
  spec.email         = ["chris@cteague.com.au"]
  spec.summary       = %q{Build UI tests for manual validation across multiple devices.}
  spec.description   = %q{Build UI tests for manual validation across multiple devices.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency     "locoyo"
  spec.add_runtime_dependency     "httparty"
  spec.add_runtime_dependency     "rspec"
end
