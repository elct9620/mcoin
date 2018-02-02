# frozen_string_literal: true

module Mcoin
  module Data
    # :nodoc:
    class Ticker
      attr_reader :market, :type, :currency
      attr_accessor :last, :ask, :bid, :low, :high, :volume, :timestamp

      def initialize(market, type, currency, data = {})
        @market = market
        @type = type
        @currency = currency
        data.each do |key, value|
          send("#{key}=", value)
        end
      end

      def time
        Time.at(timestamp.to_i).to_s
      end

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

      def influx_time
        (timestamp.to_f * (10**9)).to_i.to_s
      end
    end
  end
end
