module Mcoin
  module Market
    # :nodoc:
    class Bitstamp < Base
      # rubocop:disable Metrics/LineLength
      ENDPOINT = 'https://www.bitstamp.net/api/v2/ticker/%<type>s%<currency>s/'.freeze

      def to_ticker
        fetch
        Data::Ticker.new(
          @type, @currency,
          last: @data['last'],
          ask: @data['ask'], bid: @data['bid'],
          low: @data['low'], high: @data['high'],
          volume: @data['volume']
        )
      end
    end
  end
end
