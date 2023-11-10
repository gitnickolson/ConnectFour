# frozen_string_literal: true

require './lib/board'
require_relative 'spec_helper'

RSpec.describe Board do
  subject(:board) { Board.new }

  let(:local_matrix) { Array.new(6) { Array.new(7, '⚫️') } }

  describe '#print' do
    it 'prints the board' do
      expected_output = <<~BOARD
        1  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        2  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        3  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        4  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        5  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        6  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
         ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                 1    2    3    4    5    6    7
      BOARD

      expect { board.print }.to output(expected_output).to_stdout
    end

    it 'prints the board with a red chip at the bottom of the 5th column' do
      local_matrix[5][4] = '🔴'

      board.instance_variable_set(:@board_matrix, local_matrix)

      expected_output = <<~BOARD
        1  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        2  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        3  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        4  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        5  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        6  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | 🔴 | ⚫️ | ⚫️ |  ┃
         ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                 1    2    3    4    5    6    7
      BOARD

      expect { board.print }.to output(expected_output).to_stdout
    end

    it 'prints the board with a blue chip at the bottom of the 3rd column' do
      local_matrix[5][2] = '🔵'

      board.instance_variable_set(:@board_matrix, local_matrix)


      expected_output = <<~BOARD
        1  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        2  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        3  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        4  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        5  ┃  | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
        6  ┃  | ⚫️ | ⚫️ | 🔵 | ⚫️ | ⚫️ | ⚫️ | ⚫️ |  ┃
         ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                 1    2    3    4    5    6    7
      BOARD

      expect { board.print }.to output(expected_output).to_stdout
    end
  end

  describe '#update' do
    it 'returns error when field variable is > 6' do
      expect(board.update(15, :blue)).to eql('No winner')
    end

    context 'When entering a color for the player_color parameter' do
      it 'should be translated into the blue emoji' do
        expect(board.update(5, :blue)).to eql('🔵')
      end

      it 'should be translated into the red emoji' do
        expect(board.update(5, :red)).to eql('🔴')
      end
    end

    context 'When updating the board' do
      it 'should update the board with the blue chip in the first column' do
        board.update(1, :blue)
        expect(board.send(:board_matrix)[5][0]).to eql('🔵')
      end

      it 'should update the board with the blue chip in the first column' do
        board.update(3, :red)
        expect(board.send(:board_matrix)[5][2]).to eql('🔴')
      end

      it 'should update the board with the blue chip in the first column' do
        board.update(3, :red)
        expect(board.send(:board_matrix)[5][2]).to eql('🔴')
      end

      it 'should stack the chips if there are multiple chips in one column' do
        board.update(3, :red)
        board.update(3, :blue)
        board.update(3, :red)
        expect(board.send(:board_matrix)[5][2]).to eql('🔴')
        expect(board.send(:board_matrix)[4][2]).to eql('🔵')
        expect(board.send(:board_matrix)[3][2]).to eql('🔴')
      end
    end
  end

  describe 'winner' do
    it 'returns blue if there are four blue chips in a horizontal row' do
      local_matrix[5][1] = '🔵'
      local_matrix[5][2] = '🔵'
      local_matrix[5][3] = '🔵'
      local_matrix[5][4] = '🔵'

      board.instance_variable_set(:@board_matrix, local_matrix)

      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four blue chips in a vertical row' do
      local_matrix[5][2] = '🔵'
      local_matrix[4][2] = '🔵'
      local_matrix[3][2] = '🔵'
      local_matrix[2][2] = '🔵'

      board.instance_variable_set(:@board_matrix, local_matrix)

      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four blue chips in a right-diagonal row' do
      local_matrix[5][1] = '🔵'
      local_matrix[4][2] = '🔵'
      local_matrix[3][3] = '🔵'
      local_matrix[2][4] = '🔵'

      board.instance_variable_set(:@board_matrix, local_matrix)
      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four blue chips in a left-diagonal row' do
      local_matrix[5][4] = '🔵'
      local_matrix[4][3] = '🔵'
      local_matrix[3][2] = '🔵'
      local_matrix[2][1] = '🔵'

      board.instance_variable_set(:@board_matrix, local_matrix)

      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four red chips in a horizontal row' do
      local_matrix[5][1] = '🔴'
      local_matrix[5][2] = '🔴'
      local_matrix[5][3] = '🔴'
      local_matrix[5][4] = '🔴'

      board.instance_variable_set(:@board_matrix, local_matrix)

      expect(board.winner).to eql(:red)
    end

    it 'returns blue if there are four red chips in a vertical row' do
      local_matrix[5][2] = '🔴'
      local_matrix[4][2] = '🔴'
      local_matrix[3][2] = '🔴'
      local_matrix[2][2] = '🔴'

      board.instance_variable_set(:@board_matrix, local_matrix)

      expect(board.winner).to eql(:red)
    end

    it 'returns blue if there are four red chips in a right-diagonal row' do
      local_matrix[5][1] = '🔴'
      local_matrix[4][2] = '🔴'
      local_matrix[3][3] = '🔴'
      local_matrix[2][4] = '🔴'

      board.instance_variable_set(:@board_matrix, local_matrix)
      expect(board.winner).to eql(:red)
    end

    it 'returns blue if there are four red chips in a left-diagonal row' do
      local_matrix[5][4] = '🔴'
      local_matrix[4][3] = '🔴'
      local_matrix[3][2] = '🔴'
      local_matrix[2][1] = '🔴'

      board.instance_variable_set(:@board_matrix, local_matrix)

      expect(board.winner).to eql(:red)
    end

    it 'returns tie if the board is full' do
      local_matrix = [['🔴', '🔵', '🔴', '🔴', '🔵', '🔵', '🔴'],
                      ['🔵', '🔴', '🔵', '🔴', '🔵', '🔵', '🔵'],
                      ['🔴', '🔴', '🔵', '🔴', '🔵', '🔵', '🔵'],
                      ['🔴', '🔵', '🔵', '🔵', '🔴', '🔴', '🔴'],
                      ['🔵', '🔴', '🔴', '🔴', '🔵', '🔴', '🔴'],
                      ['🔵', '🔵', '🔴', '🔵', '🔴', '🔴', '🔵']]

      board.instance_variable_set(:@board_matrix, local_matrix)

      expect(board.winner).to eql(:tie)
    end
  end
end
