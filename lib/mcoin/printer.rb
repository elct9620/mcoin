module Mcoin
  # :nodoc:
  class Printer
    def initialize(*rows)
      @rows = rows.flatten
    end

    def print
      puts row(columns.map(&:capitalize))
      puts column_widths.map { |width| '-' * width }.join(' | ')
      @rows.each do |row|
        puts row(columns.map { |column| row.send(column) })
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
      %i[market currency type last ask bid]
    end
  end
end
