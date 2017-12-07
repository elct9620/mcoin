# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    class Common < Base
      def initialize
        super

        separator ''
        separator 'Commands: '
        print_commands

        separator ''
        separator 'Options: '
        on_tail('-v', '--version', 'Show versions') do
          puts "Mcoin #{Mcoin::VERSION}"
          exit
        end
      end

      def print_commands
        Command.commands.each do |command|
          separator "    #{command.downcase}\t" \
            "#{Command.const_get(command).description}"
        end
      end

      def parse!
        super
      rescue OptionParser::InvalidOption
        puts self
        exit
      end

      def execute
        puts self
      end
    end
  end
end
