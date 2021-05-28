# frozen_string_literal: true

require 'optparse'
require 'optparse/uri'
require 'ostruct'

module Mcoin
  # The command line interface
  module Command
    autoload :Base, 'mcoin/command/base'
    autoload :Common, 'mcoin/command/common'
    autoload :Ticker, 'mcoin/command/ticker'

    autoload :HasMarket, 'mcoin/command/ext/has_market'
    autoload :HasPair, 'mcoin/command/ext/has_pair'
    autoload :Saveable, 'mcoin/command/ext/saveable'

    class << self
      def execute
        pick.new.parse!.execute
      end

      def pick
        command = ARGV.first&.capitalize
        return Common unless commands.include?(command&.to_sym)

        const_get(command)
      end

      def commands
        constants.select do |klass|
          const_get(klass).is_a?(Class)
        end - %i[Base Common]
      end
    end
  end
end
