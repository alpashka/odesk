# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'odesk/version'

Gem::Specification.new do |gem|
  gem.name          = "odesk"
  gem.version       = Odesk::VERSION
  gem.authors       = ["Michael Vigor"]
  gem.email         = ["michael@bigbluedev.com"]
  gem.description   = "Client library to interact with the ODesk REST api"
  gem.summary       = ""
  gem.homepage      = "https://github.com/bigblue/odesk"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "faraday", [">= 0.8"]
  gem.add_dependency "faraday_middleware", [">= 0.9"]
  gem.add_dependency "simple_oauth", [">= 0.2"]
end
