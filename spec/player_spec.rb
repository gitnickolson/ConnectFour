# frozen_string_literal: true

require './lib/player'

describe Player do
  let(:player) { Player.new(1) }

  describe '#get_color' do
    it 'returns blue when 1 is the argument' do
      expect(player.get_color(1)).to eql(:blue)
    end
  end

  describe '#get_color' do
    it 'returns red when 2 is the argument' do
      expect(player.get_color(2)).to eql(:red)
    end
  end

  describe '#get_color' do
    it 'returns false if color is not valid' do
      expect(player.get_color(32)).to eql(nil)
    end
  end

  # get_input muss noch vertestet werden
end
