Changelog
=========

2.1.1
-----

*March 31, 2010*

  * VotD will now return a default scripture of John 3:16 in KJV if there's
    any error enountered when accessing the VotD from the source server.
    
    
2.1.0
-----

*March 31, 2012*

  * [Add] `.custom_html` method that takes a block of custom formatted
    HTML to override the `.to_html` method.
  * [Add] `.to_text` method that returns a text-formatted version
    of the VotD.
    Aliased to `.to_s`.
  * [Add] `.custom_text` method that takes a block of custom formatted
    text to override the `.to_text` method.
  * [Add] `.translation` -> aliased to `.version`.
  
  
2.0.0
-----

*March 30, 2012*
  
  * New `.copyright` attribute containing any copyright information provided
    by the VotD service. This may will cause any existing use of
    `Votd::BibleGateway.text` to lose copyright data unless you add it.
    (Previously, we were just using the copyright data that Bible Gateway
    appended to the end of the Bible text.)
    Bible Gateway requires that you add this copyright data. 
  * Remove any reference to Ruby 1.8.7. Will not be supporting.
  

1.2.0
-----

*March 26, 2012*

  * Refactored shared code from BibleGateway and NetBible into a Base class
    and inherited from this. This makes the code base easier to manage and
    extend. See the [CONTRIBUTING](https://github.com/doctorbh/votd/blob/master/CONTRIBUTING.md)
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
