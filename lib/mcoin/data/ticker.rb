module Mcoin
  module Data
    # :nodoc:
    class Ticker
      attr_reader :type, :currency
      attr_accessor :last, :ask, :bid, :low, :high, :volume

      def initialize(type, currency, data = {})
        @type = type
        @currency = currency
        data.each do |key, value|
          send("#{key}=", value)
        end
      end
    end
  end
end
