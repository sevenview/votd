# frozen_string_literal: true

require_relative "lib/votd/version"

Gem::Specification.new do |spec|
  spec.name = "votd"
  spec.version = Votd::VERSION
  spec.authors = ["Steve Clarke"]
  spec.email = ["steve@sevenview.ca"]

  spec.summary = "Generate a (Bible) Verse of the Day using various web service wrappers"
  spec.description = "A Ruby gem that wraps Bible verse-of-the-day web services including " \
                     "BibleGateway, NetBible, and OurManna. Provides both a library and CLI."
  spec.homepage = "https://github.com/sevenview/votd"
  spec.license = "MIT"
  spec.required_ruby_version = [">= 3.3", "< 4.1"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files = Dir.glob(%w[lib/**/*.rb exe/* LICENSE README.md CHANGELOG.md])

  spec.bindir = "exe"
  spec.executables = %w[votd]
  spec.require_paths = ["lib"]

  spec.add_dependency "feedjira", "~> 4.0"
  spec.add_dependency "httparty", "~> 0.22"
  spec.add_dependency "thor", "~> 1.3"
end
