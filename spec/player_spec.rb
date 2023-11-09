# frozen_string_literal: true

require './lib/player'

describe Player do
  let(:player) { Player.new }

  describe '#color' do
    it 'returns nil' do
      expect(player.color).to be_nil
    end
  end

  describe '#get_input' do
    it 'can receive input' do
      allow(player).to receive(:gets).and_return("5\n")
      expect(player.get_input).to eql(5)
    end

    it 'loops until it gets valid input' do
      allow(player).to receive(:gets).and_return("12\n", "foo\n", "5\n")
      expect(player.get_input).to eql(5)
    end

    it 'displays error message for invalid input' do
      allow(player).to receive(:gets).and_return("10\n", "5\n")
      expect do
        player.get_input
      end.to output("Error: Please enter a valid integer number ranging from 1 to 7\n").to_stdout
    end

    it 'uses the first number of a string of mixed characters' do
      allow(player).to receive(:gets).and_return('5§/(§$foo')
      expect(player.get_input).to eq(5)
    end

    it 'displays error message when an empty string is entered' do
      allow(player).to receive(:gets).and_return('', "5\n")
      expect do
        player.get_input
      end.to output("Error: Please enter a valid integer number ranging from 1 to 7\n").to_stdout
    end

    it 'displays error message when a string of letters or something equal is entered' do
      allow(player).to receive(:gets).and_return('brrr', '...', '(§/$)&6/%(/)9023§$/92', "5\n")
      expect do
        player.get_input
      end.to output("Error: Please enter a valid integer number ranging from 1 to 7
Error: Please enter a valid integer number ranging from 1 to 7
Error: Please enter a valid integer number ranging from 1 to 7\n").to_stdout
    end

    it 'automatically rounds decimal numbers' do
      allow(player).to receive(:gets).and_return("2.5\n")
      expect(player.get_input).to eql(2)
    end
  end
end
