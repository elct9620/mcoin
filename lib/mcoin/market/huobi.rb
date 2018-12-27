# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Huobi < Base
      ENDPOINT = 'https://api.huobi.pro/market/detail/merged?symbol=%<type>s%<currency>s'

      def watch(type, currency)
        @pairs.add({ type: type.to_s.downcase, currency: currency.to_s.downcase })
      end

      private

      def build_ticker(pair, response)
        response = response['tick']
        Data::Ticker.new(
          :Huobi, pair[:type].upcase, pair[:currency].upcase,
          last: response['close'].to_s,
          ask:  response['ask'][0].to_s, bid:  response['bid'][0].to_s,
          low:  response['low'].to_s, high: response['high'].to_s,
          volume: response['vol'],
          timestamp: Time.now.utc.to_i
        )
      end
    end
  end
end
