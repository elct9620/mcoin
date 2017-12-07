# frozen_string_literal: true

module Mcoin
  module Data
    # :nodoc:
    class Ticker
      attr_reader :market, :type, :currency
      attr_accessor :last, :ask, :bid, :low, :high, :volume

      def initialize(market, type, currency, data = {})
        @market = market
        @type = type
        @currency = currency
        data.each do |key, value|
          send("#{key}=", value)
        end
      end

      def to_influx(tags = {}, values = {})
        tags = { type: @type, currency: @currency, market: @market }.merge(tags)
        values = {
          last: @last,
          ask: @ask, bid: @bid,
          low: @low, high: @high,
          volume: @volume
        }.merge(values)
        "prices,#{tags.map { |t| t.join('=') }.join(',')} " \
        "#{values.map { |v| v.join('=') }.join(',')}"
      end
    end
  end
end
