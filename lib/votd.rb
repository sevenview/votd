require "time"
require "json"
require "httparty"
require "votd/version"
require "votd/votd_error"
require "votd/base"
require "votd/bible_gateway"
require "votd/netbible"

# This class acts as the entry point to all sub-modules that are used
# to interact with various Verse of the Day web services.
module Votd
  include HTTParty
end

