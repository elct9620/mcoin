# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    module HasMarket
      def self.included(base)
        base.option(:multiple, :market, '-m', '--market MARKET',
                    Mcoin::Market.available,
                    "Available: #{Mcoin::Market.available.join(', ')}")
      end
    end
  end
end
