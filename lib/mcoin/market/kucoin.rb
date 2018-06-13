# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Kucoin < Base
      ENDPOINT = 'https://api.kucoin.com/v1/open/tick?symbol=%<type>s-%<currency>s'

      def to_ticker
        fetch
        response = @data['data']
        Data::Ticker.new(
          :Kucoin, @type, @currency,
          last: response['lastDealPrice'].to_s,
          ask:  response['sell'].to_s, bid:  response['buy'].to_s,
          low:  response['low'].to_s,  high: response['high'].to_s,
          volume: response['vol'].to_s,
          timestamp: @data['timestamp'] / 1000.to_f
        )
      end
    end
  end
end
