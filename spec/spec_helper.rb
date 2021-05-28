# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.start do
  load_profile 'test_frameworks'

  add_filter %r{/vendor/}

  if ENV.fetch('CI', false)
    formatter SimpleCov::Formatter::MultiFormatter.new([
                                                         SimpleCov::Formatter::SimpleFormatter,
                                                         SimpleCov::Formatter::CoberturaFormatter,
                                                         SimpleCov::Formatter::HTMLFormatter
                                                       ])
  end
end

Dir[Bundler.root.join('spec/support/**/*.rb')].sort.each { |support| require support }

require 'mcoin'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
