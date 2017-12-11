# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Bitfinex < Base
      ENDPOINT = 'https://api.bitfinex.com/v1/pubticker/%<type>s%<currency>s'

      def to_ticker
        fetch
        Data::Ticker.new(
          :Bitfinex,
          @type, @currency,
          last: @data['last_price'],
          ask: @data['ask'], bid: @data['bid'],
          low: @data['low'], high: @data['high'],
          volume: @data['volume'],
          timestamp: @data['timestamp']
        )
      end
    end
  end
end
