# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    module Saveable
      def self.included(base)
        base.class_eval do
          option(:single, :endpoint, '-e',
                 '--endpoint ENDPOINT', URI, 'Database Endpoint')
          option(:single, :database, '-d',
                 '--database NAME', String, 'Database Name')
          option(:single, :username, '-u',
                 '--username USERNAME', String, 'Database Username')
          option(:single, :password, '-p',
                 '--password PASSWORD', String, 'Database Password')
        end
      end

      def save?
        option.endpoint && option.database
      end
    end
  end
end
