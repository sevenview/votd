# frozen_string_literal: true

require File.expand_path("../lib/votd/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Steve Clarke", "Chris Clarke"]
  gem.email = ["steve@sevenview.ca", "chris@seven7.ca"]
  gem.summary = "Generate a (Bible) Verse of the Day using various web service wrappers"
  gem.homepage = "https://github.com/sevenview/votd"

  gem.files = `git ls-files -z`.split("\x0").reject { |f| f.start_with?("spec/", "bin/smoke_test") }
  gem.executables = ["votd"]
  gem.name = "votd"
  gem.require_paths = ["lib"]
  gem.version = Votd::VERSION
  gem.license = "MIT"

  gem.required_ruby_version = ">= 3.3"

  gem.add_dependency "feedjira"
  gem.add_dependency "httparty"
  gem.add_dependency "thor"
end
