# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Bitstamp < Base
      ENDPOINT = 'https://www.bitstamp.net/api/v2/ticker/%<type>s%<currency>s/'

      def watch(type, currency)
        @pairs.add({ type: type.to_s.downcase, currency: currency.to_s.downcase })
      end

      private

      def build_ticker(pair, response)
        Data::Ticker.new(
          :Bitstamp,
          pair[:type].upcase, pair[:currency].upcase,
          last: response['last'],
          ask: response['ask'], bid: response['bid'],
          low: response['low'], high: response['high'],
          volume: response['volume'],
          timestamp: response['timestamp']
        )
      end
    end
  end
end
