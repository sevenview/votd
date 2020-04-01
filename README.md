# VotD - (Bible) Verse of the Day

[![Build Status](https://secure.travis-ci.org/doctorbh/votd.png?branch=master)](http://travis-ci.org/Sevenview/votd)
[![Code Climate](https://codeclimate.com/github/sevenview/votd.png)](https://codeclimate.com/github/sevenview/votd)

VotD (Verse of the Day) is a Ruby Gem that wraps various web services that generate
daily Bible Verses.


Currently the gem supports three VotD web services:

* [Bible Gateway](http://www.biblegateway.com) - Multiple Translations
* [Bible.org](http://labs.bible.org) - NETBible Translation
* [ESV Bible Web Service](http://www.esvapi.org/) - ESV Translation

If you are able to contribute modules for any of these, please see our [CONTRIBUTING](https://github.com/Sevenview/votd/blob/master/CONTRIBUTING.md) file. Let us know before you begin work in case someone else has a module in-progress.

## Installation

Add this line to your application's Gemfile:

    gem 'votd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install votd

## Quick Start

To use VotD in your code:

    require 'votd'

    votd = Votd::BibleGateway.new
    
    votd.reference    # Ephesians 2:8-9
    votd.text         # For by grace you are saved through faith...
    votd.date         # 2012-03-24
    votd.version      # NIV
    votd.version_name # New International Version
    votd.link         # https://www.biblegateway.com/passage/?search=ephesians+2%3A8-9&version=31
    votd.copyright    # Copyright © ...
    
*NOTE: If there's an error encountered while accessing the VotD service a default verse of John 3:16 in the KVJ
is returned. This ensures that something is returned no matter what.*

## Votd::BibleGateway

To use the Bible Gateway service, which generates a verse of the day in multiple
translations:

```ruby
    require 'votd'
    votd = Votd::BibleGateway.new        # uses default New International Version
    # or
    votd = Votd::BibleGateway.new(:kjv)  # uses King James Version (see chart below for more)
```

The following English translations are available:

| Code | Version|  Name |
| -----|------|---|
| :amp  | AMP | Amplified Bible |
| :asv  | ASV | American Standard Version |
| :ceb | CEB | Common English Bible |
| :darby | DARBY | Darby Translation |
| :esv | ESV | English Standard Version |
| :esvu | ESVU | English Standard Version Anglicised |
| :gw | GW | God's Word Translation |
| :hcsb | HCSB | Holman Christian Standard Bible |
| :kjv | KJV | King James Version |
| :leb | LEB | Lexham English Bible |
| :nasb | NASB | New American Standard Bible |
| :nirv | NIRV | New International Reader's Version |
| :niv | NIV | New International Version |
| :nivuk | NIVUK | New International Version - UK |
| :nlt | NLT | New Living Translation |
| :nlv | NLV | New Life Version |
| :phillips | PHILLIPS | J.B. Phillips New Testament |
| :we | WE | Worldwide English (New Testament) |
| :wyc | WYC | Wycliffe Bible |
| :ylt | YLT | Young's Literal Translation |

Note: Although Bible Gateway has many other English translations, these are the
only ones that have copyright approval for use with the verse of the day
service as of November 2019.

## Votd::NetBible

To use the NET Bible service, which generates a NET Bible translation verse of
the day:

```ruby
    require 'votd'
    votd = Votd::NetBible.new
```

## Votd::ESVBible

To use the ESV Bible Web Service, which generates a English Standard Version 
verse of the day:

```ruby
    require 'votd'
    votd = Votd::BibleGateway.new
```

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

&copy; 2012-2019 Christopher Clarke, Stephen Clarke. See [LICENSE](https://github.com/Sevenview/votd/blob/master/LICENSE) for details.
