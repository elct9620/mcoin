# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    class Base < OptionParser
      class << self
        attr_reader :options, :commands

        def description(description = nil)
          return @description if description.nil?

          @description = description
        end

        def option(mode, name, *args)
          @options ||= []
          @options.push(Option.new(mode, name, *args))
        end
      end

      attr_reader :option

      def initialize
        super

        prepare
        self.banner = '=== Mcoin : BTC Monitor Tool ==='
        self.class.options&.each { |option| option.register(self) }
      end

      def prepare
        @option = OpenStruct.new
      end

      def parse!
        super
        self
      end

      def execute
        raise NotImplementedError
      end

      # Option Register
      class Option
        def initialize(mode, name, *args)
          @mode = mode
          @name = name.to_sym
          @args = args
        end

        def register(command)
          case @mode
          when :single then register_as_single(command)
          when :multiple then register_as_multiple(command)
          end
        end

        def register_as_single(command)
          command.on(*@args, ->(value) { command.option[@name] = value })
        end

        def register_as_multiple(command)
          command.option[@name] ||= []
          command.on(*@args, ->(value) { command.option[@name].push(value) })
        end
      end
    end
  end
end
