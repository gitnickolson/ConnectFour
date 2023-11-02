# frozen_string_literal: true

class Board
  attr_accessor :board_matrix, :colors

  def initialize
    @board_matrix = [[0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0]]
    #                1, 2, 3, 4, 5, 6, 7
    @colors = {}
  end

  def print_board
    board_matrix.each_with_index do |element, index|
      puts "#{index + 1} ┃  | #{element.map { |field| "#{field} | " }.join(',').gsub(',', '')} ┃"
    end
    puts '  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'
    puts '       1   2   3   4   5   6   7'
  end

  def update_board(field, player_color)
    field -= 1

    row = find_free_field(field)

    return nil if row.class != Integer

    board_matrix[row][field] = player_color
    print_board
  end

  def find_free_field(field)
    row = 5
    while row >= 0
      return row if (board_matrix[row][field]).zero?

      row -= 1
    end

    puts "Error: You can't place any more chips in this column"
  end
end
