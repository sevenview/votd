require "votd/version"
require "votd/netbible"
require "time"
require "json"
require "httparty"

# This class acts as the entry point to all sub-modules that are used
# to interact with various Verse of the Day web services.
module Votd
  include HTTParty
end
