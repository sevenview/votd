# Changelog
* March 31, 2012 (2.1.0)
  * [Add] `.custom_html` method that takes a block of custom formatted
    HTML to override the `.to_html` method.
  * [Add] `.to_text` method that returns a text-formatted version
    of the VotD.
    Aliased to `.to_s`.
  * [Add] `.custom_text` method that takes a block of custom formatted
    text to override the `.to_text` method.
  * [Add] `.translation` -> aliased to `.version`.
    
* March 30, 2012 2.0.0 release
  * New `.copyright` attribute containing any copyright information provided
    by the VotD service. This may will cause any existing use of
    `Votd::BibleGateway.text` to lose copyright data unless you add it.
    (Previously, we were just using the copyright data that Bible Gateway
    appended to the end of the Bible text.)
    Bible Gateway requires that you add this copyright data. 
  * Remove any reference to Ruby 1.8.7. Will not be supporting.

* March 26, 2012 1.2.0 release
  * Refactored shared code from BibleGateway and NetBible into a Base class
    and inherited from this. This makes the code base easier to manage and
    extend. See the [CONTRIBUTING](https://github.com/doctorbh/votd/blob/master/CONTRIBUTING.md) page for more info on how to make use of the Base class.
  * Updated docs
  	 
* March 25, 2012 1.1.0 release
  * Added support for [Bible Gateway](www.biblegateway.com)
    * only supporting the default NIV translation for now, but
      planning to implement other translations
  * Updated votd command line tool to load from Bible Gateway
  * Moved more code toward compatibility with Ruby 1.8

* March 25, 2012 1.0.1 release
  * Updated documentation links
  
* March 24, 2012 1.0.0 release
  * Initial release with support for Bible.org's [NETBible](http://labs.bible.org/)
  * YARD documentation added
