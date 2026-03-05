# frozen_string_literal: true

require "time"
require "json"
require "httparty"

# This class acts as the entry point to all sub-modules that are used
# to interact with various Verse of the Day web services.
module Votd
  class << self
    # Set a Logger-compatible object to receive error messages when
    # a provider fails to fetch a verse.
    #
    # @example
    #   Votd.logger = Logger.new($stderr)
    attr_accessor :logger

    # Register a callback to be invoked when a provider error occurs.
    # The block receives the provider class and the wrapped FetchError.
    #
    # @example
    #   Votd.on_error do |provider_class, error|
    #     Sentry.capture_exception(error)
    #   end
    #
    # @yield [provider_class, error] invoked when a provider fails
    # @yieldparam [Class] provider_class the provider class that failed (e.g. Votd::BibleGateway)
    # @yieldparam [FetchError] error the wrapped exception
    # @return [void]
    def on_error(&block)
      @on_error = block
    end

    # Returns the registered on_error callback, if any.
    # @api private
    # @return [Proc, nil]
    def on_error_callback
      @on_error
    end

    # Resets logger and on_error callback. Useful in tests.
    # @return [void]
    def reset_configuration
      @logger = nil
      @on_error = nil
    end
  end
end

require "votd/helper/text"
require "votd/version"
require "votd/votd_error"
require "votd/fetch_error"
require "votd/base"
require "votd/bible_gateway"
require "votd/netbible"
require "votd/ourmanna"
require "votd/esvbible"
