# frozen_string_literal: true

class Board
  attr_reader :board_matrix

  def initialize
    @board_matrix = [%w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️],
                     %w[⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️, ⚫️]]
  end

  def print
    board_matrix.each_with_index do |element, index|
      puts "#{index + 1}  ┃  | #{element.map { |field| "#{field} | " }.join(',').gsub(',', '')} ┃"
    end
    puts ' ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    puts '         1    2    3    4    5    6    7'
  end

  def update(field, player_color)
    colors = {
      blue: '🔵',
      red: '🔴'
    }
    field -= 1

    color = colors[player_color]
    row = find_free_field(field)

    return 'No winner' if row.nil?

    board_matrix[row][field] = color
  end

  def winner
    if horizontal_check == :blue || vertical_check == :blue ||
       right_diagonal_check == :blue || left_diagonal_check == :blue
      return :blue
    elsif horizontal_check == :red || vertical_check == :red ||
          right_diagonal_check == :red || left_diagonal_check == :red
      return :red
    end

    nil
  end

  private

  def find_free_field(field)
    row = 5
    while row >= 0
      return row if (board_matrix[row][field]) == '⚫️,' || (board_matrix[row][field]) == '⚫️'

      row -= 1
    end

    puts "Error: You can't place any more chips in this column"
    nil
  end

  def horizontal_check
    board_matrix.each do |row|
      row = row.join(',')
      return :blue if row.include?('🔵,🔵,🔵,🔵')
      return :red if row.include?('🔴,🔴,🔴,🔴')
    end
  end

  def vertical_check
    board_matrix.transpose.each do |column|
      column = column.join(',')
      return :blue if column.include?('🔵,🔵,🔵,🔵')
      return :red if column.include?('🔴,🔴,🔴,🔴')
    end
  end

  def right_diagonal_check
    (3..5).each do |row|
      4.times do |col|
        diagonal = [board_matrix[row][col], board_matrix[row - 1][col + 1], board_matrix[row - 2][col + 2],
                    board_matrix[row - 3][col + 3]].join(',')
        return :blue if diagonal.include?('🔵,🔵,🔵,🔵')
        return :red if diagonal.include?('🔴,🔴,🔴,🔴')
      end
    end
  end

  def left_diagonal_check
    (3..5).each do |row|
      (3..6).each do |col|
        diagonal = [board_matrix[row][col], board_matrix[row - 1][col - 1], board_matrix[row - 2][col - 2],
                    board_matrix[row - 3][col - 3]].join(',')
        return :blue if diagonal.include?('🔵,🔵,🔵,🔵')
        return :red if diagonal.include?('🔴,🔴,🔴,🔴')
      end
    end
  end
end
