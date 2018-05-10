# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Huobi < Base
      ENDPOINT = 'https://api.huobi.pro/market/detail/merged?symbol=%<type>s%<currency>s'

      def to_ticker
        fetch
        response = @data['tick']
        Data::Ticker.new(
          :Huobi, @type, @currency,
          last: response['close'].to_s,
          ask:  response['ask'][0].to_s, bid:  response['bid'][0].to_s,
          low:  response['low'].to_s, high: response['high'].to_s,
          volume: response['vol'],
          timestamp: Time.now.utc.to_i
        )
      end

      def uri
        options = { type: @type.downcase, currency: @currency.downcase }
        uri = format(self.class.const_get(:ENDPOINT), options)
        URI(uri)
      end
    end
  end
end
