# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Hitbtc < Base
      ENDPOINT = 'https://api.hitbtc.com/api/2/public/ticker/%<type>s%<currency>s'

      private

      def build_ticker(pair, response)
        fetch
        Data::Ticker.new(
          :Hitbtc, pair[:type], pair[:currency],
          last: response['last'],
          ask: response['ask'], bid: response['bid'],
          high: response['high'], low: response['low'],
          volume: response['volume'],
          timestamp: Time.parse(response['timestamp']).to_f
        )
      end
    end
  end
end
