# frozen_string_literal: true

require './lib/game'

RSpec.describe Game do
  subject(:game) { Game.new }

  describe '#initialize' do
    context 'When initialized' do
      it 'creates board as a new instance of Board' do
        allow(Board).to receive(:new).and_call_original

        game
        expect(Board).to have_received(:new)
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

    it 'starts the game loop' do
      allow(game).to receive(:start_loop)

      game.start
      expect(game).to have_received(:start_loop)
    end
  end
end
