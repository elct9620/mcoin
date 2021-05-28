# frozen_string_literal: true

module Mcoin
  module Data
    # The market information struct
    #
    # @since 0.7.0
    class Ticker
      # @since 0.7.0
      attr_reader :market, :type, :currency

      # @since 0.7.0
      attr_accessor :last, :ask, :bid, :low, :high, :volume, :timestamp

      # @param [String|Symbol] market
      # @param [String|Symbol] crypto type
      # @param [String|Symbol] currency
      # @param [Hash] market data
      def initialize(market, type, currency, data = {})
        @market = market
        @type = type
        @currency = currency
        data.each do |key, value|
          send("#{key}=", value)
        end
      end

      # @return [Time] the timestamp object
      def time
        Time.at(timestamp.to_i).to_s
      end

      # @deprecated will refactor to Influx adapter
      def to_influx
        tags = { type: @type, currency: @currency, market: @market }
        values = {
          last: @last,
          ask: @ask, bid: @bid,
          low: @low, high: @high,
          volume: @volume
        }
        "prices,#{tags.map { |t| t.join('=') }.join(',')} " \
        "#{values.map { |v| v.join('=') }.join(',')} #{influx_time}"
      end

      private

      # @deprecated will refactor to Influx adapter
      def influx_time
        (timestamp.to_f * (10**9)).to_i.to_s
      end
    end
  end
end
