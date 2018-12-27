# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Bitflyer < Base
      ENDPOINT = 'https://api.bitflyer.jp/v1/getticker?product_code=%<type>s_%<currency>s'

      private

      def build_ticker(pair, response)
        Data::Ticker.new(
          :Bitflyer, pair[:type], pair[:currency],
          last: response['ltp'].to_s,
          ask: response['best_ask'].to_s, bid: response['best_bid'].to_s,
          low: response['best_bid'].to_s, high: response['best_ask'].to_s,
          volume: response['volume'], # Trading volume in 24 hours
          timestamp: Time.parse(response['timestamp']).to_f
        )
      end
    end
  end
end
