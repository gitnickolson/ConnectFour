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

    puts "Welcome to Connect Four! The player that wants to play with blue chips shall start!
To play, just enter a number ranging from 1 to 7 to place your chip in the specified column."

    start_loop
  end

  private

  def start_loop
    loop
  end

  def loop
    #stuff
  end

  attr_reader :board
end
