# frozen_string_literal: true

module Mcoin
  # :nodoc:
  class Printer
    def initialize(*rows)
      @rows = rows.flatten
      @outputs = []

      build
    end

    def print
      if @rows.empty?
        puts 'No result found'
      else
        puts @outputs
      end
    end

    def build
      return if @rows.empty?
      build_header
      build_rows
    end

    def build_header
      @outputs << row(columns.map(&:capitalize))
      @outputs << column_widths.map { |width| '-' * width }.join(' | ')
    end

    def build_rows
      @rows.each do |row|
        @outputs << row(columns.map { |column| row.send(column) })
      end
    end

    def row(row)
      row.map(&:to_s)
         .zip(column_widths)
         .map { |item| item.reduce(:ljust) }
         .join(' | ')
    end

    def column_widths
      @widths ||= columns.map do |column|
        [@rows.map(&column).map(&:size).max, column.size].max
      end
    end

    def columns
      # TODO: Load from command
      %i[market currency type last ask bid]
    end
  end
end
