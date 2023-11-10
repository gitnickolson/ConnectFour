# frozen_string_literal: true

require './lib/game'
require_relative 'spec_helper'

RSpec.describe Game do
  subject(:game) { Game.new }

  describe '#initialize' do
    context 'When initialized' do
      it 'creates board as a new instance of Board' do
        allow(Board).to receive(:new).and_call_original

        game
        expect(Board).to have_received(:new)
      end

      it 'creates an instance of BluePlayer' do
        allow(BluePlayer).to receive(:new).and_call_original

        game
        expect(BluePlayer).to have_received(:new)
      end

      it 'creates an instance of RedPlayer' do
        allow(RedPlayer).to receive(:new).and_call_original

        game
        expect(RedPlayer).to have_received(:new)
      end

      it 'initializes a turn coutner variable with 0' do
        game
        expect(game.turn).to eql(0)
      end
    end
  end

  describe '#start' do
    let(:board) { instance_double(Board) }

    it 'calls the print method on the board' do
      allow(Board).to receive(:new).and_return(board)
      allow(board).to receive(:print)

      game.start
      expect(board).to have_received(:print)
    end

    it 'displays welcome message' do
      expected_board_output = <<~BOARD
        1  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        2  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        3  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        4  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        5  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        6  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
         ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                 1    2    3    4    5    6    7
      BOARD

      expect do
        game.start
      end.to output("#{expected_board_output}Welcome to Connect Four! The player that wants to play with blue chips shall start!
To play, just enter a number ranging from 1 to 7 to place your chip in the specified column.\n").to_stdout
    end

    it 'calls the start loop method' do
      allow(game).to receive(:start_loop)

      game.start
      expect(game).to have_received(:start_loop)
    end
  end

  describe '#loop' do
    context 'Chooses an active player based on turn every round' do
      it 'chooses player one when turn is even' do
        game.instance_variable_set(:@turn, 2)
        game.loop

        expect(game.active_player).to eql(game.player_one)
      end

      it 'chooses player two when turn is uneven' do
        game.instance_variable_set(:@turn, 7)
        game.loop

        expect(game.active_player).to eql(game.player_two)
      end
    end

    it 'call the get_input method on the active player' do
    end
  end
end
