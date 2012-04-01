require "time"
require "json"
require "httparty"

# This class acts as the entry point to all sub-modules that are used
# to interact with various Verse of the Day web services.
module Votd
  include HTTParty
end

require "votd/version"
require "votd/helper"
require "votd/votd_error"
require "votd/base"
require "votd/bible_gateway"
require "votd/netbible"
