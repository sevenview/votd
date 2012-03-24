module Votd
  module ESV
    def self.votd
      File.read("spec/fixtures/votd.json")
    end
  end
end
