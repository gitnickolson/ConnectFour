# frozen_string_literal: true

require './lib/board'
require 'stringio'

RSpec.describe Board do
  let(:board) { Board.new }

  xdescribe '#update_board' do
    it 'returns Error when field variable is > 6' do
      expect(board.update_board(15, :blue)).to eql('No winner')
    end

    context 'When entering the color blue for the player_color parameter' do
      it 'should be translated into the blue emoji' do
        expect(board.update_board(5, :blue)).to eql('🔵')
      end
    end

    context 'When entering the color red for the player_color parameter' do
      it 'should be translated into the red emoji' do
        expect(board.update_board(5, :red)).to eql('🔴')
      end
    end

    context 'When updating the board' do
      it 'should update the board with the blue chip in the first column' do
      end
    end
  end

  xdescribe '#print_board' do
    it 'prints the initial board correctly' do
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

      expect { board.print_board }.to output(expected_output).to_stdout
    end

    it 'prints the board with a red chip at the bottom of the 5th column' do
      board.update_board(5, :red)

      expect { board.print_board }.to output(printed_board).to_stdout
    end

    it 'prints the board with a blue chip at the bottom of the 3rd column' do
      board.board_matrix[5][2] = '🔵'

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

      expect { board.print_board }.to output(expected_output).to_stdout
    end
  end

  xdescribe '#winner' do
    it 'returns blue if there are four blue chips in a horizontal row' do
      board.board_matrix[5][1] = '🔵'
      board.board_matrix[5][2] = '🔵'
      board.board_matrix[5][3] = '🔵'
      board.board_matrix[5][4] = '🔵'

      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four blue chips in a vertical row' do
      board.board_matrix[5][2] = '🔵'
      board.board_matrix[4][2] = '🔵'
      board.board_matrix[3][2] = '🔵'
      board.board_matrix[2][2] = '🔵'

      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four blue chips in a right-diagonal row' do
      board.board_matrix[5][1] = '🔵'
      board.board_matrix[4][2] = '🔵'
      board.board_matrix[3][3] = '🔵'
      board.board_matrix[2][4] = '🔵'

      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four blue chips in a left-diagonal row' do
      board.board_matrix[5][4] = '🔵'
      board.board_matrix[4][3] = '🔵'
      board.board_matrix[3][2] = '🔵'
      board.board_matrix[2][1] = '🔵'

      expect(board.winner).to eql(:blue)
    end

    it 'returns blue if there are four red chips in a horizontal row' do
      board.board_matrix[5][1] = '🔴'
      board.board_matrix[5][2] = '🔴'
      board.board_matrix[5][3] = '🔴'
      board.board_matrix[5][4] = '🔴'

      expect(board.winner).to eql(:red)
    end

    it 'returns blue if there are four red chips in a vertical row' do
      board.board_matrix[5][2] = '🔴'
      board.board_matrix[4][2] = '🔴'
      board.board_matrix[3][2] = '🔴'
      board.board_matrix[2][2] = '🔴'

      expect(board.winner).to eql(:red)
    end

    it 'returns blue if there are four red chips in a right-diagonal row' do
      board.board_matrix[5][1] = '🔴'
      board.board_matrix[4][2] = '🔴'
      board.board_matrix[3][3] = '🔴'
      board.board_matrix[2][4] = '🔴'

      expect(board.winner).to eql(:red)
    end

    it 'returns blue if there are four red chips in a left-diagonal row' do
      board.board_matrix[5][4] = '🔴'
      board.board_matrix[4][3] = '🔴'
      board.board_matrix[3][2] = '🔴'
      board.board_matrix[2][1] = '🔴'

      expect(board.winner).to eql(:red)
    end
  end
end
