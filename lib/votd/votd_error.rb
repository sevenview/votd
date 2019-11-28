module Votd
  # Votd exception class. This will be thrown on errors returned
  # by Votd.
  class VotdError < StandardError
  end

  class InvalidBibleVersion < VotdError
  end
end
