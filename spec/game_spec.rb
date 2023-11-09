# frozen_string_literal: true

require './lib/game'

RSpec.xdescribe Game do
  let(:game) { Game.new }

  describe '#start' do
    it 'prints welcome message' do
      game.instance_variable_set(:@game_ended, true)
      expected_output = "Welcome to Connect Four! The player that wants to play with blue chips shall start!
To play, just enter a number ranging from 1 to 7 to place your chip in the specified column.\n"
      expect { game.start }.to output(expected_output).to_stdout
    end
  end

  describe '#loop' do
    it 'evaluates that player one is active' do
      game.instance_variable_set(:@game_turn, 2)
      game.instance_variable_set(:@player_input, 3)

      game.loop

      expect(game.instance_variable_get(:@active_player)).to eql(game.player_one)
    end

    it 'evaluates that player two is active' do
      game.instance_variable_set(:@game_turn, 3)
      game.instance_variable_set(:@player_input, 3)

      game.loop

      expect(game.instance_variable_get(:@active_player)).to eql(game.player_two)
    end

    it 'sets the player color to blue for player one' do
      game.instance_variable_set(:@game_turn, 2)
      game.instance_variable_set(:@player_input, 3)

      game.loop

      expect(game.instance_variable_get(:@player_color)).to eql(:blue)
    end

    it 'sets the player color to red for player two' do
      game.instance_variable_set(:@game_turn, 3)
      game.instance_variable_set(:@player_input, 3)

      game.loop

      expect(game.instance_variable_get(:@player_color)).to eql(:red)
    end

    xit 'returns nil if player input is nil' do
      game.instance_variable_set(:@game_turn, 2)
      game.instance_variable_set(:@player_input, nil)

      game.loop
      expect(game).to receive(:loop).and_return(nil)
    end
  end
end
