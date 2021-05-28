# frozen_string_literal: true

RSpec.describe Mcoin do
  it 'has a version number' do
    expect(Mcoin::VERSION).not_to be nil
  end
end
