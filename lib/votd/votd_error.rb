# frozen_string_literal: true

module Votd
  # Votd exception class. This will be thrown on errors returned
  # by Votd.
  class VotdError < StandardError
  end

  # Raised when an unknown Bible version symbol is passed to
  # {BibleGateway#initialize}.
  class InvalidBibleVersion < VotdError
  end
end
