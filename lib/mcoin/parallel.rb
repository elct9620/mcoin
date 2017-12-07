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
    end
  end
end
