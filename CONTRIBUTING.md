Inside of Votd's source is a module with a couple classes and files referring to each version. By contributing to Votd with plugins, you can help keep the gem fresh with new versions.

The most basic way to get the code is to simply click the 'Fork' button in the corner of the page. This will hand over a copy of the code to you so that you can really do whatever you want.

To create a plugin, you must find an API with XML or JSON parsing, and wrap it in a module located in `lib/votd`. Once this is complete, you can start by creating a new file in `spec` to test your plugin before your pull request. Votd uses the testing framework [Rspec](http://rspec.info/) to manage testing, so use the Rspec syntax enhancements rather than another framework.

Once your tests are done, work on the parsing system with your code, and you're ready to go!

Just pop us a [Pull Request](https://github.com/doctorbh/votd/pulls) and you're code will be overviewed and ready to go soon.