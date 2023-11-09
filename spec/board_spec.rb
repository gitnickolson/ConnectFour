# frozen_string_literal: true

require './lib/board'

RSpec.describe Board do
  subject(:board) { Board.new }

  describe '#initialize' do
    context 'When initialized' do
      it 'the board matrix is defined' do
        board
        expect(board.board_matrix).to eql([%w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                                           %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                                           %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                                           %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                                           %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                                           %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️]])
      end
    end
  end

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
      board.board_matrix[5][4] = '🔴'

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
        expect(board.board_matrix[5][0]).to eql('🔵')
      end

      it 'should update the board with the blue chip in the first column' do
        board.update(3, :red)
        expect(board.board_matrix[5][2]).to eql('🔴')
      end

      it 'should update the board with the blue chip in the first column' do
        board.update(3, :red)
        expect(board.board_matrix[5][2]).to eql('🔴')
      end

      it 'should stack the chips if there are multiple chips in one column' do
        board.update(3, :red)
        board.update(3, :blue)
        board.update(3, :red)
        expect(board.board_matrix[5][2]).to eql('🔴')
        expect(board.board_matrix[4][2]).to eql('🔵')
        expect(board.board_matrix[3][2]).to eql('🔴')
      end
    end
  end

  describe 'winner' do
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
