# frozen_string_literal: true

require './lib/red_player'

describe RedPlayer do
  it 'is a subclass of Player' do
    expect(described_class).to be < Player
  end

  context 'when initialized' do
    let(:player_color) { :red }

    it 'is assigned with the color red' do
      expect(player_color).to eq(:red)
    end
  end
end
