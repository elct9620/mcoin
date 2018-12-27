# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Bitfinex < Base
      ENDPOINT = 'https://api.bitfinex.com/v1/pubticker/%<type>s%<currency>s'

      private

      def build_ticker(pair, response)
        Data::Ticker.new(
          :Bitfinex,
          pair[:type], pair[:currency],
          last: response['last_price'],
          ask: response['ask'], bid: response['bid'],
          low: response['low'], high: response['high'],
          volume: response['volume'],
          timestamp: response['timestamp']
        )
      end
    end
  end
end
