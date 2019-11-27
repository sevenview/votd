# -*- encoding: utf-8 -*-
require File.expand_path('../lib/votd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steve Clarke", "Chris Clarke"]
  gem.email         = ["steve@sevenview.ca", "chris@seven7.ca"]
  gem.summary       = %q{Generate a (Bible) Verse of the Day using various web service wrappers}
  gem.homepage      = "https://github.com/sevenview/votd"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "votd"
  gem.require_paths = ["lib"]
  gem.version       = Votd::VERSION
  gem.license       = "MIT"

  gem.required_ruby_version = ">= 1.9.3"

  gem.add_runtime_dependency     "httparty"
  gem.add_runtime_dependency     "feedjira"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "guard-bundler"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "redcarpet"
end
