# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Cryptopia < Base
      ENDPOINT = 'https://www.cryptopia.co.nz/api/GetMarket/%<type>s_%<currency>s'

      def to_ticker
        fetch
        response = @data['Data']
        Data::Ticker.new(
          :Cryptopia, @type, @currency,
          last: response['LastPrice'],
          ask:  response['AskPrice'],  bid: response['BidPrice'],
          high: response['High'], low: response['Low'],
          volume: response['Volume'],
          timestamp: Time.now.utc.to_i
        )
      end
    end
  end
end
