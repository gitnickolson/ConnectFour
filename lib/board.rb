class Board
  attr_accessor :board_matrix
  def initialize
    @board_matrix = [[0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0]]
    #                1, 2, 3, 4, 5, 6, 7
  end

  def print_board
    board_matrix.each_with_index do |element, index|
      puts "#{index + 1} ┃  | " + element.map {|field| field.to_s + " | "}.join(",").gsub(",", "") + " ┃"
    end
    puts "  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
    puts "       1   2   3   4   5   6   7"
  end
end

board = Board.new
board.print_board