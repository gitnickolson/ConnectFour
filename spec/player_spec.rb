# frozen_string_literal: true

require './lib/player'

describe Player do
  let(:player) { Player.new (:blue) }

  describe '#initialize' do
    it 'initializes the player class with the color blue' do
      expect(Player.new(:blue)).to be_a(Player)
    end

    it 'initializes the player class with the color red' do
      expect(Player.new(:red)).to be_a(Player)
    end

    it 'fails when entering something else' do
      expect{ Player.new(:something) }.to raise_error
    end
  end

  describe '#get_color' do
    it 'returns blue for a blue player' do
      expect(player.get_color).to eql(:blue)
    end

    it 'returns red for a red player' do
      player = Player.new(:red)
      expect(player.get_color).to eql(:red)
    end
  end

  xdescribe "#get_input" do
    it "returns valid input" do
      allow(player).to receive(:gets).and_return("3")


      expect(player).to receive(:is_number_valid?).with(3).and_return(true)

    end
  end
end
