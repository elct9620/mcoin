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
          last: @data['ltp'],
          ask: @data['best_ask'], bid: @data['best_bid'],
          low: @data['best_bid'], high: @data['best_ask'],
          volume: @data['volume'], # Trading volume in 24 hours
          timestamp: Time.parse(@data['timestamp']).to_f
        )
      end
    end
  end
end
