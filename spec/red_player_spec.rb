# frozen_string_literal: true

require './lib/red_player'
require_relative 'spec_helper'

describe RedPlayer do
  it 'is a subclass of Player' do
    expect(described_class).to be < Player
  end

  describe '#color' do
    it 'returns red' do
      expect(RedPlayer.new.color).to eq(:red)
    end
  end
end
