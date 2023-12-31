# frozen_string_literal: true

require './lib/game'
require_relative 'spec_helper'
require 'stringio'

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
      allow(board).to receive(:winner).and_return(nil, :blue)

      game.start
      expect(board).to have_received(:print).at_least(:once)
      expect(board).to have_received(:update).with(1, :blue).at_least(:once)
    end

    it 'calls the start loop method' do
      allow(board).to receive(:winner).and_return(:blue)
      allow(game).to receive(:start_loop)

      game.start
      expect(game).to have_received(:start_loop)
    end
  end

  describe '#loop' do
    context 'For different turn counts' do
      it 'chooses player one when turn is even' do
        allow(board).to receive(:winner).and_return(nil, :blue)
        game.start

        expect(blueplayer).to have_received(:get_input).at_least(:once)
      end

      it 'chooses player two when turn is odd' do
        allow(board).to receive(:winner).and_return(nil, nil, :blue)
        game.start

        expect(redplayer).to have_received(:get_input).at_least(:once)
      end

      it 'switches between players after receiving input' do
        allow(board).to receive(:winner).and_return(nil, nil, nil, :blue)
        game.start

        expect(redplayer).to have_received(:get_input).at_least(:once)
        expect(blueplayer).to have_received(:get_input).at_least(:twice)
      end

      it 'prints the board every time it is called' do
        allow(board).to receive(:winner).and_return(nil, nil, nil, :blue)
        allow(blueplayer).to receive(:get_input).and_return(1)

        game.start
        expect(board).to have_received(:print).at_least(:twice)
      end

      it 'prints an error if row is full' do
        output = StringIO.new
        $stdout = output
        allow(board).to receive(:winner).and_return(nil, nil, :blue)
        allow(board).to receive(:update).and_return(nil)

        game.start
        $stdout = STDOUT
        console_output = output.string.strip
        previous_last_line = console_output.lines[-2].strip
        expect(previous_last_line).to eq("Error: You can't place any more chips in this column")
      end
    end

    it 'sends update to board' do
      allow(board).to receive(:winner).and_return(nil, nil, :blue)
      allow(blueplayer).to receive(:get_input).and_return(1)

      game.start

      expect(board).to have_received(:update).with(2, :red).at_least(:once)
    end
  end

  describe 'ended?' do
    it 'outputs that blue won if board.winner == :blue' do
      output = StringIO.new
      $stdout = output
      allow(blueplayer).to receive(:get_input).and_return(1)
      allow(board).to receive(:winner).and_return(:blue)

      game.start

      $stdout = STDOUT
      console_output = output.string.strip
      last_line = console_output.lines.last.strip
      expect(last_line).to eq('Congratulations! Blue won!')
    end

    it 'outputs that red won if board.winner == :red' do
      output = StringIO.new
      $stdout = output
      allow(blueplayer).to receive(:get_input).and_return(1)
      allow(board).to receive(:winner).and_return(:red)

      game.start

      $stdout = STDOUT
      console_output = output.string.strip
      last_line = console_output.lines.last.strip
      expect(last_line).to eq('Congratulations! Red won!')
    end

    it 'outputs that it ended in a tie if board.winner == :tie' do
      output = StringIO.new
      $stdout = output
      allow(blueplayer).to receive(:get_input).and_return(1)
      allow(board).to receive(:winner).and_return(:tie)

      game.start

      $stdout = STDOUT
      console_output = output.string.strip
      last_line = console_output.lines.last.strip
      expect(last_line).to eq("Oh no! It's a tie!")
    end
  end
end
