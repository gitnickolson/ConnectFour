# frozen_string_literal: true

require './lib/player'

describe Player do
  let(:player) { Player.new }
  describe '#get_input' do
    it 'can receives input' do
      allow(player).to receive(:gets).and_return("5\n")
      expect(player.get_input).to eq(5)
    end

    it 'displays error message for invalid input' do
      allow(player).to receive(:gets).and_return("10\n")
      expect { player.get_input }.to output("Error: Please enter a number ranging from 1 to 7\n").to_stdout
    end
  end

  describe '#is_number_valid?' do
    it 'returns true for valid input' do
      expect(player.send(:is_number_valid?, 3)).to be_truthy
    end

    it 'returns false for invalid input' do
      expect(player.send(:is_number_valid?, 10)).to be_falsy
    end
  end
end
