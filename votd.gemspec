# -*- encoding: utf-8 -*-
require File.expand_path('../lib/votd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steve Clarke", "Chris Clarke"]
  gem.email         = ["doctorbh@ninjanizr.com", "beakr@ninjanizr.com"]
  gem.description   = %q{A simple API wrapper for generating a Verse of the day.}
  gem.summary       = %q{Generate a Verse of the day in a simple API wrapper.}
  gem.license       = 'MIT'
  gem.homepage      = "https://github.com/doctorbh/votd"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.bindir        = 'bin'
  gem.name          = "votd"
  gem.require_paths = ["lib"]
  gem.version       = Votd::VERSION

  gem.required_ruby_version    = '>= 1.9'
  gem.add_runtime_dependency     "httparty"
  gem.add_development_dependency "fakeweb"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "redcarpet"
end
