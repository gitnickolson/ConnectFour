# frozen_string_literal: true

require './lib/board'

RSpec.describe Board do
  describe '#print_board' do
    let(:board) { Board.new }

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
      board.board_matrix[5][4] = '🔴' # Assume the player placed a white chip in the 5th column

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

      expect { board.print_board }.to output(expected_output).to_stdout
    end

    it 'prints the board with a blue chip at the bottom of the 3rd column' do
      board.board_matrix[5][2] = '🔵' # Assume the player placed a white chip in the 5th column

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

  describe '#update_board' do
    it 'Returns Error when field variable is > 6' do
      board = Board.new
      expect(board.update_board(15, :blue)).to eql('Error')
    end
  end

  describe '#winner' do
    it 'Returns blue if there are four blue chips in a horizontal row' do
      board = Board.new
      allow(board).to receive(:horizontal_check).and_return(:blue)

      if board.horizontal_check == :blue || board.vertical_check == :blue ||
         board.right_diagonal_check == :blue || board.left_diagonal_check == :blue
        expect(board.winner).to eql(:blue)
      end
    end

    it 'Returns blue if there are four blue chips in a vertical row' do
      board = Board.new
      allow(board).to receive(:vertical_check).and_return(:blue)

      if board.horizontal_check == :blue || board.vertical_check == :blue ||
         board.right_diagonal_check == :blue || board.left_diagonal_check == :blue
        expect(board.winner).to eql(:blue)
      end
    end

    it 'Returns blue if there are four blue chips in a right-diagonal row' do
      board = Board.new
      allow(board).to receive(:right_diagonal_check).and_return(:blue)

      if board.horizontal_check == :blue || board.vertical_check == :blue ||
         board.right_diagonal_check == :blue || board.left_diagonal_check == :blue
        expect(board.winner).to eql(:blue)
      end
    end

    it 'Returns blue if there are four blue chips in a left-diagonal row' do
      board = Board.new
      allow(board).to receive(:left_diagonal_check).and_return(:blue)

      if board.horizontal_check == :blue || board.vertical_check == :blue ||
         board.right_diagonal_check == :blue || board.left_diagonal_check == :blue
        expect(board.winner).to eql(:blue)
      end
    end

    it 'Returns blue if there are four red chips in a horizontal row' do
      board = Board.new
      allow(board).to receive(:horizontal_check).and_return(:red)

      if board.horizontal_check == :red || board.vertical_check == :red ||
         board.right_diagonal_check == :red || board.left_diagonal_check == :red
        expect(board.winner).to eql(:red)
      end
    end

    it 'Returns blue if there are four red chips in a vertical row' do
      board = Board.new
      allow(board).to receive(:vertical_check).and_return(:red)

      if board.horizontal_check == :red || board.vertical_check == :red ||
         board.right_diagonal_check == :red || board.left_diagonal_check == :red
        expect(board.winner).to eql(:red)
      end
    end

    it 'Returns blue if there are four red chips in a right-diagonal row' do
      board = Board.new
      allow(board).to receive(:right_diagonal_check).and_return(:red)

      if board.horizontal_check == :red || board.vertical_check == :red ||
         board.right_diagonal_check == :red || board.left_diagonal_check == :red
        expect(board.winner).to eql(:red)
      end
    end

    it 'Returns blue if there are four red chips in a left-diagonal row' do
      board = Board.new
      allow(board).to receive(:left_diagonal_check).and_return(:red)

      if board.horizontal_check == :red || board.vertical_check == :red ||
         board.right_diagonal_check == :red || board.left_diagonal_check == :red
        expect(board.winner).to eql(:red)
      end
    end
  end
end
