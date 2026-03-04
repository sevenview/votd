# frozen_string_literal: true

module Votd
  # ESVBible is no longer functional. The gnpcb.org RSS endpoint used by this
  # class was shut down. The ESV API (https://api.esv.org/) requires an API key
  # and does not provide a verse-of-the-day endpoint.
  #
  # Use Votd::BibleGateway.new(:esv) for an ESV verse of the day instead.
  class ESVBible
    def initialize
      raise Votd::VotdError, 'Votd::ESVBible is no longer supported. ' \
        'The gnpcb.org endpoint has been shut down. ' \
        'Use Votd::BibleGateway.new(:esv) for an ESV verse of the day.'
    end
  end
end
