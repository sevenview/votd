# frozen_string_literal: true

require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)

desc "Generate YARD docs"
YARD::Rake::YardocTask.new

task default: :spec

desc "Release current version (creates git tag and triggers GitHub Actions)"
task :release do
  require_relative "lib/votd/version"
  version = Votd::VERSION

  # Check if tag already exists
  if system("git rev-parse v#{version} >/dev/null 2>&1")
    warn "\e[31mError: Tag v#{version} already exists\e[0m"
    abort
  end

  # Check for uncommitted changes to version file
  unless system("git diff --quiet lib/votd/version.rb")
    warn "\e[31mError: lib/votd/version.rb has uncommitted changes\e[0m"
    warn "\e[90mCommit version changes first\e[0m"
    abort
  end

  puts "\e[1mRelease v#{version}\e[0m"
  puts "\e[90mThis will:\e[0m"
  puts "\e[90m  1. Create tag: v#{version}\e[0m"
  puts "\e[90m  2. Push tag to origin\e[0m"
  puts "\e[90m  3. Trigger GitHub Actions to build and release\e[0m"
  puts

  print "Continue? [y/N] "
  answer = $stdin.gets.chomp.downcase
  abort "Cancelled." unless answer == "y"

  puts "\e[90mCreating tag v#{version}...\e[0m"
  system("git tag -a 'v#{version}' -m 'Release v#{version}'") || abort("Failed to create tag")

  puts "\e[90mPushing to origin...\e[0m"
  system("git push origin 'v#{version}'") || abort("Failed to push tag")

  puts
  puts "\e[32mRelease v#{version} created!\e[0m"
  puts "\e[90mCheck progress: https://github.com/sevenview/votd/actions\e[0m"
end
