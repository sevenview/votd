# VotD - (Bible) Verse of the Day

VotD (Verse of the Day) is a Ruby Gem that wraps various web services that generate
daily Bible Verses.

Currently the gem supports two VotD web services:

* [Bible.org](http://labs.bible.org) - NETBible Translation
* [Bible Gateway](http://www.biblegateway.com) - NIV Translations (Currently only supporting the default NIV, but planning on adding more.)

Other services are are planned:

* [Bible Gateway](http://www.biblegateway.com) - More Translations
 
* [ESV Bible Web Service](http://www.esvapi.org/) - ESV Translation

If you are able to contribute modules for any of these, please see our [CONTRIBUTING](http://rubydoc.info/gems/votd/file/CONTRIBUTING.md) file. Let us know before you begin work in case someone else has a module in-progress.

## Installation

Add this line to your application's Gemfile:

    gem 'votd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install votd

## Usage

To use VotD in your code:

    require 'votd'
    
    votd = Votd.NetBible.new
    
    # or votd = Votd.BibleGateway.new
    
    votd.reference   # Ephesians 2:8-9
    votd.text        # For by grace you are saved through faith...
    votd.date        # 2012-03-24
    votd.version     # NETBible
    
    votd.to_html     # <p class="votd-text">For by grace you are saved through faith...
    
Full text of HTML formatted VotD looks like the following

    <p class="votd-text">For by grace you are saved through faith... it is not from works, so that no one can boast.</p>
    <p>
    <span class="votd-reference"><strong>Ephesians 2:8-9</strong></span>
	<span class="votd-version"><em>(NETBible)</em></span>
	</p>

You can then use the provided CSS classes to style the VotD.

For command-line usage see [here](https://github.com/doctorbh/votd/wiki/Shell-Tool)

## Documentation

Documentation may be found [here](http://rubydoc.info/gems/votd/file/README.md)

## Source Code

Source code is available in our [GitHub repository](https://github.com/doctorbh/votd).

## Requests

To submit bug, feature requests, patches see our [Issues List](https://github.com/doctorbh/votd/issues) on GitHub.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write passing tests/specs (we use [RSpec](http://rspec.info))
4. Commit your changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

See more on [CONTRIBUTING](http://rubydoc.info/gems/votd/file/CONTRIBUTING.md).

## Changelog

See our [CHANGELOG](http://rubydoc.info/gems/votd/file/CHANGELOG.md) file.

## TODO

See our [TODO](http://rubydoc.info/gems/votd/file/TODO.md) file.

## Authors

Christopher Clarke <beakr@ninjanizr.com>

Stephen Clarke <doctorbh@ninjanizr.com>

## Copyright

(The MIT License)

&copy; 2012 Christopher Clarke, Stephen Clarke. See [LICENSE](http://rubydoc.info/gems/votd/1.0.0/file/LICENSE) for details.
