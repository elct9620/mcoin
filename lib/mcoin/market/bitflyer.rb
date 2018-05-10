# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Bitflyer < Base
      ENDPOINT = 'https://api.bitflyer.jp/v1/getticker?product_code=%<type>s_%<currency>s'

      def to_ticker
        fetch
        Data::Ticker.new(
          :Bitflyer, @type, @currency,
          last: @data['ltp'].to_s,
          ask: @data['best_ask'].to_s, bid: @data['best_bid'].to_s,
          low: @data['best_bid'].to_s, high: @data['best_ask'].to_s,
          volume: @data['volume'], # Trading volume in 24 hours
          timestamp: Time.parse(@data['timestamp']).to_f
        )
      end
    end
  end
end
