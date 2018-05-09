# frozen_string_literal: true

require 'time'

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
          last: response['lastDealPrice'],
          ask:  response['sell'], bid:  response['buy'],
          low:  response['low'],  high: response['high'],
          volume: response['vol'],
          timestamp: @data['timestamp']
        )
      end
    end
  end
end
