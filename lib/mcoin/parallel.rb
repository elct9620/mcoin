# frozen_string_literal: true

module Mcoin
  # Parallel execute helper
  #
  # @since 0.1.0
  class Parallel
    class << self
      # @param [Array] items to async map
      # @param [String|Symbol] the map method
      #
      # @since 0.1.0
      def map(items, method)
        items.map do |item|
          Thread.new { item.send(method) }
        end.map(&:join).map(&:value)
      end

      # @param [Array] items to async execute
      # @param [String|Symbol] the method to async execute
      #
      # @since 0.1.7
      def async(items, method)
        items.each do |item|
          Thread.new { yield item.send(method) }
        end
      end
    end
  end
end
