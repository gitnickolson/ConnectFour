# frozen_string_literal: true

require './lib/blue_player'

describe BluePlayer do
  it 'is a subclass of Player' do
    expect(described_class).to be < Player
  end

  describe '#color' do
    it 'returns blue' do
      expect(BluePlayer.new.color).to eq(:blue)
    end
  end
end
