# frozen_string_literal: true

require './lib/blue_player'

describe BluePlayer do
  it 'is a subclass of Player' do
    expect(described_class).to be < Player
  end

  context 'when initialized' do
    let(:player_color) { :blue }

    it 'is assigned with the color blue' do
      expect(player_color).to eq(:blue)
    end
  end
end
