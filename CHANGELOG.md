Changelog
=========

3.0.1
-----
*November 27, 2019*

* Throw error when invalid version option passed to BibleGateway initializer

3.0.0
-----
*November 27, 2019*

* Choose a Bible version from Bible Gateway. Default is still NIV. (see docs
  for supported versions)
* Add `.version_name` (alias: `.translation_name`) to get full version name.
  (e.g. "New International Version")
* Add `.link` to get a link to the verse on the associated Bible site

2.2.0
-----
*October 31, 2013*

* Added ESV Support (thanks [Sebastian Hirsch](https://github.com/SebastianHirsch))

2.1.6
-----
*January 24, 2013*

* Fixed minor documentation error
* Changed repository owner on GitHub


2.1.5
-----

*October 4, 2012*

* Updated Feedzirra dependency

2.1.4
-----

*April 6, 2012*

* BUG FIX - NetBible was broken after the Helper::Text reorg. This
  releases fixes the bug.

2.1.3
-----

*April 5, 2012*

* Reorganized Helper modules (used internally only)
* Minor bug fixes

2.1.2
-----------------

*April 4, 2012*

* Added custom exception type `Votd::VotdError`
* Added `Votd::Helper` module to provide common helper methods to all modules
* Cleaned up command-line version to wrap text properly
* Now cleans HTML tags from NetBible text when they are generated
* Now cleans verses that are sentence fragments:
  * Prepend Bible verse with '...' if verse doesn't start with a capital
    letter
  * Append '...' if verse doesn't end with a period '.'

2.1.1
-----

*March 31, 2012*

* VotD will now return a default scripture of John 3:16 in KJV if there's
  any error enountered when accessing the VotD from the source server.

2.1.0
-----

*March 31, 2012*

* Added `.custom_html` method that takes a block of custom formatted
  HTML to override the `.to_html` method.
* Added `.to_text` method that returns a text-formatted version
  of the VotD. Aliased to `.to_s`.
* Added `.custom_text` method that takes a block of custom formatted
  text to override the `.to_text` method.
* Added `.translation` -> aliased to `.version`.
  
  
2.0.0
-----

*March 30, 2012*
  
* New `.copyright` attribute containing any copyright information provided
  by the VotD service. This may will cause any existing use of
  `Votd::BibleGateway.text` to lose copyright data unless you add it.
  (Previously, we were just using the copyright data that Bible Gateway
  appended to the end of the Bible text.)
  Bible Gateway requires that you add this copyright data. 
* Removed any reference to Ruby 1.8.7. Will not be supporting.
  

1.2.0
-----

*March 26, 2012*

* Refactored shared code from BibleGateway and NetBible into a Base class
  and inherited from this. This makes the code base easier to manage and
  extend. See the [CONTRIBUTING](https://github.com/Sevenview/votd/blob/master/CONTRIBUTING.md)
  page for more info on how to make use of the Base class.
* Updated docs
  
  
1.1.0
-----	
 
*March 25, 2012*

* Added support for [Bible Gateway](www.biblegateway.com)
  * only supporting the default NIV translation for now, but
    planning to implement other translations
* Updated votd command line tool to load from Bible Gateway
* Moved more code toward compatibility with Ruby 1.8


1.0.1
-----

*March 25, 2012*

* Updated documentation links
  

1.0.0
-----

*March 24, 2012*

* Initial release with support for Bible.org's [NETBible](http://labs.bible.org/)
* YARD documentation added
