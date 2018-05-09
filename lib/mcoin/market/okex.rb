# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Okex < Base
      ENDPOINT = 'https://www.okex.com/api/v1/ticker.do?symbol=%<type>s_%<currency>s'

      def to_ticker
        fetch
        response = @data['ticker']
        Data::Ticker.new(
          :Okex, @type, @currency,
          last: response['last'],
          ask:  response['sell'], bid:  response['buy'],
          low:  response['low'],  high: response['high'],
          volume: response['vol'],
          timestamp: @data['date'].to_i
        )
      end
    end
  end
end
