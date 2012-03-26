#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

task :default => :spec

desc "Run RSpec tests [default]"
RSpec::Core::RakeTask.new

desc "Generate YARD docs"
YARD::Rake::YardocTask.new

