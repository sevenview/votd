# Contributing

Inside of VotD's source is a module with classes and files referring
to various Bible web services. By contributing to VotD with plugins you
can help keep the gem fresh with new versions.

The most basic way to get the code is to simply fork the code base on
GitHub. This will hand over a copy of the code to you so that you can
really do whatever you want.

To create a plugin, you must find an API and wrap it in a module
located in `lib/votd`.

* Your class must inherit from {Votd::Base} and
needs to override the {Votd::Base#get_votd} method.

* Your class must supply the `BIBLE_VERSION` constant, or set `@version` inside the class somewhere.

* Your initializer must consist of at least the following:

      ```ruby
      # Initializes the MyBible class
      def initialize
      	super
      end
      ```
    
Creating a new file in `spec` to test your plugin before your pull
request. VotD uses the testing framework [Rspec](http://rspec.info/)
to manage testing, so use the Rspec syntax enhancements rather than
another framework.

Once your tests are done, work on the parsing system with your code,
and you're ready to go!

Just pop us a [Pull Request](https://github.com/Sevenview/votd/pulls)
and you're code will be overviewed and ready to go soon.

## Summary

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write passing tests/specs (we use [RSpec](http://rspec.info))
4. Commit your changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request