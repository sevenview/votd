# Changelog

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
