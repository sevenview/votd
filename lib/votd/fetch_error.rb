# frozen_string_literal: true

module Votd
  # Raised when a provider fails to fetch or parse a verse of the day.
  # The original exception is preserved as #cause.
  class FetchError < VotdError
  end
end
