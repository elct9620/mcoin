# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    module HasPair
      def self.included(base)
        base.option(:multiple, :pair, '-P', '--pair BTC-USD')
      end
    end
  end
end
