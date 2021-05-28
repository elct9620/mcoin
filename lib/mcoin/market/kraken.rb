# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Kraken < Base
      ENDPOINT = 'https://api.kraken.com/0/public/Ticker?pair=%<type>s%<currency>s'

      def watch(type, currency)
        type = swap_btc(type.to_s.upcase)
        super
      end

      private

      # TODO: Resolve Metrics/AbcSize, Metrics/MethodLength
      def build_ticker(pair, response) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        return if response['result'].nil?

        response = response.dig('result', "X#{pair[:type]}Z#{pair[:currency]}")
        Data::Ticker.new(
          :Kraken,
          swap_btc(pair[:type]), pair[:currency],
          last: response['c'][0],
          ask: response['a'][0], bid: response['b'][0],
          low: response['l'][1], high: response['h'][1],
          volume: response['v'][1],
          timestamp: Time.now.to_i
        )
      end

      def swap_btc(type)
        return 'BTC' if type == 'XBT'
        return 'XBT' if type == 'BTC'

        type
      end
    end
  end
end
