# frozen_string_literal: true

RSpec.describe Mcoin::Market do
  describe '.pick' do
    subject { described_class.pick(:Bitfinex) }

    it { is_expected.to eq(Mcoin::Market::Bitfinex) }
  end

  describe '.available' do
    subject { described_class.available }

    it { is_expected.not_to include(:Base) }
  end
end
