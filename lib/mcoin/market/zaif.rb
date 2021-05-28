# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Zaif < Base
      ENDPOINT = 'https://api.zaif.jp/api/1/ticker/%<type>s_%<currency>s'

      def watch(type, currency)
        type = swap_cms(type.to_s.downcase)
        @pairs.add({ type: type, currency: currency.to_s.downcase })
      end

      private

      # TODO: Resolve Metrics/AbcSize
      def build_ticker(pair, response) # rubocop:disable Metrics/AbcSize
        Data::Ticker.new(
          :Zaif, swap_cms(pair[:type]).upcase, pair[:currency].upcase,
          last: response['last'].to_s,
          ask: response['ask'].to_s, bid: response['bid'].to_s,
          high: response['high'].to_s, low: response['low'].to_s,
          volume: response['volume'],
          timestamp: Time.now.to_i
        )
      end

      def swap_cms(type)
        return 'erc20.cms' if type == 'cms'
        return 'cms' if type == 'erc20.cms'

        type
      end
    end
  end
end
