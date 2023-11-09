# frozen_string_literal: true

require_relative 'player'
require_relative 'blue_player'
require_relative 'red_player'
require_relative 'board'

class Game
  def initialize
    @board = Board.new
  end

  def start
    board.print
  end

  private

  attr_reader :board
end
