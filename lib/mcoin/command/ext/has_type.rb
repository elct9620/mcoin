# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    module HasType
      def self.included(base)
        base.option(:single, :type, '-t', '--type TYPE',
                    Mcoin::TYPES, "Available: #{Mcoin::TYPES.join(', ')}")
        base.option(:single, :currency, '-c', '--currency CURRENCY',
                    Mcoin::CURRENCY, "Available: #{Mcoin::CURRENCY.join(', ')}")
      end
    end
  end
end
