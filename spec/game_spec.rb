# frozen_string_literal: true

require './lib/game'
require_relative 'spec_helper'

RSpec.describe Game do
  board_matrix = []

  subject(:game) { Game.new }

  let(:blueplayer) { instance_double(BluePlayer, get_input: 1, color: :blue) }
  let(:redplayer) { instance_double(RedPlayer, get_input: 2, color: :red) }
  let(:board) { instance_double(Board, update: board_matrix, print: nil) }

  before do
    allow(BluePlayer).to receive(:new).and_return(blueplayer)
    allow(RedPlayer).to receive(:new).and_return(redplayer)
    allow(Board).to receive(:new).and_return(board)
  end

  describe '#initialize' do
    context 'When initialized' do
      it 'creates board as a new instance of Board' do
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
    end
  end

  describe '#start' do
    it 'calls the print method on the board' do
      game.start
      expect(board).to have_received(:print)
      expect(board).to have_received(:update).with(2, :red)
    end

    xit 'displays welcome message and prints the board' do
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
    context 'For different turn counts' do
      it 'chooses player one when turn is even' do
        game.instance_variable_set(:@turn, 0)
        game.start

        expect(blueplayer).to have_received(:get_input).at_least(:once)
      end

      it 'chooses player two when turn is odd' do
        game.instance_variable_set(:@turn, 1)
        game.start

        expect(redplayer).to have_received(:get_input).at_least(:once)
      end

      it 'switches between players after receiving input' do
        game.instance_variable_set(:@turn, 2)
        game.start

        expect(redplayer).to have_received(:get_input).at_least(:once)
        expect(blueplayer).to have_received(:get_input).at_least(:twice)
      end
    end

    it 'sends update to board' do
      allow(board).to receive(:winner).with(:tie)
      allow(blueplayer).to receive(:get_input).and_return(1)

      game.instance_variable_set(:@turn, 1)
      game.start

      expect(board).to have_received(:update).with(1, :blue).at_least(:once)
    end
  end
end
