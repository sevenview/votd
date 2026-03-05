# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run all tests
bundle exec rake spec
# or simply
bundle exec rspec

# Run a single spec file
bundle exec rspec spec/lib/votd/bible_gateway_spec.rb

# Run a single example by line number
bundle exec rspec spec/lib/votd/bible_gateway_spec.rb:42

# Generate YARD documentation
bundle exec rake yard

# Run tests continuously during development
bundle exec guard
```

## Architecture

This is a Ruby gem (`votd`) that wraps Bible verse-of-the-day web services.

**Class hierarchy:**
- `Votd::Base` — abstract base class. Implements `to_html`, `to_text`, `custom_html`, `custom_text`. Subclasses override the private `get_votd` method.
- `Votd::BibleGateway < Base` — fetches via RSS/Feedjira; accepts a version symbol (e.g. `:niv`, `:kjv`) from the `BIBLE_VERSIONS` hash.
- `Votd::NetBible < Base` — fetches via JSON API from bible.org; NETBible translation only.
- `Votd::OurManna < Base` — fetches via JSON API from ourmanna.com; NIV translation only.
- `Votd::ESVBible` — **deprecated**. Raises `Votd::VotdError` on instantiation. The upstream gnpcb.org endpoint no longer exists. Direct users to `BibleGateway.new(:esv)`.

**Error handling pattern:** Provider `get_votd` methods raise `Votd::FetchError` on any failure (network, parse, etc.) with the original exception preserved as `#cause`. Errors are reported via `Votd.logger` (if set) and `Votd.on_error` callback (if registered) before raising. `Votd::InvalidBibleVersion` is raised eagerly in `BibleGateway#initialize` for unknown version symbols.

**Helpers:**
- `Votd::Helper::Text` — strips HTML tags, cleans verse start/end punctuation.
- `Votd::Helper::CommandLine` — `banner` and `word_wrap` for the CLI binary.

**Testing:** Uses RSpec + WebMock with hand-crafted fixtures (not VCR cassettes) in `spec/fixtures/<provider>/`. HTTP calls are stubbed via `fake_a_uri(uri, fixture_path)` and `fake_a_broken_uri(uri)` helpers in `spec/spec_helper.rb`. To test against live APIs run `bundle exec ruby bin/smoke_test`.

**CLI:** `Votd::CLI` (`lib/votd/cli.rb`) is a Thor-based CLI invoked by `exe/votd`. Supports `verse` (with `--provider`, `--translation`, `--format`) and `version` subcommands.
