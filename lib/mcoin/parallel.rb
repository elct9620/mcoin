# frozen_string_literal: true

module Mcoin
  # :nodoc:
  class Parallel
    class << self
      def map(array, method)
        array.map do |item|
          Thread.new { item.send(method) }
        end.map(&:join).map(&:value)
      end

      def async(array, method, &block)
        array.each do |item|
          Thread.new { yield item.send(method) }
        end
      end
    end
  end
end
