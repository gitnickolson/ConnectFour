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
  end
end
