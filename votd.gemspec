# -*- encoding: utf-8 -*-
require File.expand_path('../lib/votd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steve Clarke", "Chris Clarke"]
  gem.email         = ["doctorbh@ninjanizr.com", "beakr@ninjanizr.com"]
  gem.description   = %q{Generate a Bible Verse of the Day}
  gem.summary       = %q{Use ESV Bible API to look up the Verse of the Day}
  gem.homepage      = "TODO: set to github repo"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "votd"
  gem.require_paths = ["lib"]
  gem.version       = Votd::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
end
