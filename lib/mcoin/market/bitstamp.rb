# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Bitstamp < Base
      ENDPOINT = 'https://www.bitstamp.net/api/v2/ticker/%<type>s%<currency>s/'

      def to_ticker
        fetch
        Data::Ticker.new(
          :Bitstamp,
          @type, @currency,
          last: @data['last'],
          ask: @data['ask'], bid: @data['bid'],
          low: @data['low'], high: @data['high'],
          volume: @data['volume'],
          timestamp: @data['timestamp']
        )
      end
    end
  end
end
