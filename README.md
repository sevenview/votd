# VotD - (Bible) Verse of the Day

[![Build Status](https://secure.travis-ci.org/doctorbh/votd.png?branch=master)](http://travis-ci.org/Sevenview/votd)
[![Code Climate](https://codeclimate.com/github/sevenview/votd.png)](https://codeclimate.com/github/sevenview/votd)

VotD (Verse of the Day) is a Ruby Gem that wraps various web services that generate
daily Bible Verses.


Currently the gem supports three VotD web services:

* [Bible.org](http://labs.bible.org) - NETBible Translation
* [Bible Gateway](http://www.biblegateway.com) - NIV Translations (Currently only supporting the default NIV, but planning on adding more.)
* [ESV Bible Web Service](http://www.esvapi.org/) - ESV Translation

Other services are are planned:

* [Bible Gateway](http://www.biblegateway.com) - More Translations 

If you are able to contribute modules for any of these, please see our [CONTRIBUTING](https://github.com/Sevenview/votd/blob/master/CONTRIBUTING.md) file. Let us know before you begin work in case someone else has a module in-progress.

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
    
    votd = Votd::NetBible.new
    
    # or votd = Votd::BibleGateway.new
    
    votd.reference   # Ephesians 2:8-9
    votd.text        # For by grace you are saved through faith...
    votd.date        # 2012-03-24
    votd.version     # NIV
    votd.copyright   # Copyright © ...
    
*NOTE: If there's an error encountered while accessing the VotD service a default verse of John 3:16 in the KVJ
is returned. This ensures that something is returned no matter what.*

### Outputting HTML

You can use the built-in formatted HTML:
    
    votd.to_html
    
Which by default looks like the following:

    <p class="votd-text">For by grace you are saved through faith... it is not from works, so that no one can boast.</p>
    <p>
    <span class="votd-reference"><strong>Ephesians 2:8-9</strong></span>
	<span class="votd-version"><em>(NETBible)</em></span>
	</p>

You can then use the provided CSS classes to style the VotD.

You may also provide custom HTML text by using the `.custom_html` method with a block:
    
    votd.custom_html do |votd|
      "<p>#{votd.reference} - #{votd.text} (#{votd.version})</p>"
    end

`votd.to_html` now outputs:

    <p>John 3:16 - For God so loved... (KJV)</p>

### Outputting Text

You can use the built-in formatted Text:

    votd.to_text
    
Which by default looks like the following:

    For God so loved the world, that he gave his only begotten Son,
    that whosoever believeth in him should not perish, but have
    everlasting life. -- John 3:16 (KJV)
    
`.to_text` is also aliased to `.to_s`
    
You can provide custom Text formatting by using the `.custom_text` method with a block:

    votd.custom_text do |votd|
      "#{votd.reference}|#{votd.text}|#{votd.version}"
    end
    
Which outputs:

    John 3:16|For God so loved...|(KJV)
    
This returns the custom formatted text, or you can call the `.to_text` method
when ready, and your custom text will be output.

## Command Line
For command-line usage see [here](https://github.com/Sevenview/votd/wiki/Shell-Tool)

## Documentation

Documentation may be found [here](http://rubydoc.info/gems/votd/file/README.md)

## Source Code

Source code is available in our [GitHub repository](https://github.com/Sevenview/votd).

## Requests

To submit bug, feature requests, patches see our [Issues List](https://github.com/Sevenview/votd/issues) on GitHub.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write passing tests/specs (we use [RSpec](http://rspec.info))
4. Commit your changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

See more on [CONTRIBUTING](https://github.com/Sevenview/votd/blob/master/CONTRIBUTING.md).

## Changelog

See our [CHANGELOG](https://github.com/Sevenview/votd/blob/master/CHANGELOG.md) file.

## TODO

See our [TODO](https://github.com/Sevenview/votd/blob/master/TODO.md) file.

## Authors

Christopher Clarke <chris@seven7.ca>

Stephen Clarke <steve@sevenview.ca>

[Sebastian Hirsch](https://github.com/SebastianHirsch) (ESV)

## Copyright

(The MIT License)

&copy; 2012-2014 Christopher Clarke, Stephen Clarke. See [LICENSE](https://github.com/Sevenview/votd/blob/master/LICENSE) for details.
