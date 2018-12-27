# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Cryptopia < Base
      ENDPOINT = 'https://www.cryptopia.co.nz/api/GetMarket/%<type>s_%<currency>s'

      private

      def build_ticker(pair, response)
        response = response['Data']
        Data::Ticker.new(
          :Cryptopia, pair[:type], pair[:currency],
          last: response['LastPrice'].to_s,
          ask:  response['AskPrice'].to_s,  bid: response['BidPrice'].to_s,
          high: response['High'].to_s, low: response['Low'].to_s,
          volume: response['Volume'],
          timestamp: Time.now.utc.to_i
        )
      end
    end
  end
end
