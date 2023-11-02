# frozen_string_literal: true

class Board
  attr_accessor :board_matrix

  def initialize
    @board_matrix = [%w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️]]
    #                1, 2, 3, 4, 5, 6, 7
  end

  def print_board
    board_matrix.each_with_index do |element, index|
      puts "#{index + 1} ┃  | #{element.map { |field| "#{field} | " }.join(',').gsub(',', '')} ┃"
    end
    puts '  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    puts '        1    2    3    4    5    6    7'
  end

  def update_board(field, player_color)
    colors = {
      blue: "🔵",
      red: "🔴"
    }
    field -= 1

    color = colors[player_color]
    row = find_free_field(field)

    return "Error" if row == nil

    board_matrix[row][field] = color
    print_board
  end

  def find_free_field(field)
    row = 5
    while row >= 0
      return row if (board_matrix[row][field]) == "⚫️," || (board_matrix[row][field]) == "⚫️"
      row -= 1
    end

    puts "Error: You can't place any more chips in this column"
    nil
  end
end
