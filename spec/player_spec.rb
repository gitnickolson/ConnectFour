# frozen_string_literal: true

require './lib/player'

describe Player do
  describe '#get_color' do
    it 'Returns blue when 1 is the argument' do
      player = Player.new
      expect(player.get_color(1)).to eql(:blue)
    end
  end

  describe '#get_color' do
    it 'Returns red when 2 is the argument' do
      player = Player.new
      expect(player.get_color(2)).to eql(:red)
    end
  end
end
