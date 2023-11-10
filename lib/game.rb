# frozen_string_literal: true

require_relative 'blue_player'
require_relative 'red_player'
require_relative 'board'

class Game
  attr_reader :turn, :active_player, :player_one, :player_two

  def initialize
    @board = Board.new
    @player_one = BluePlayer.new
    @player_two = RedPlayer.new
    @turn = 0
  end

  def start
    board.print

    puts "Welcome to Connect Four! The player that wants to play with blue chips shall start!
To play, just enter a number ranging from 1 to 7 to place your chip in the specified column."

    start_loop
  end

  def loop
    @active_player = (turn % 2).even? ? player_one : player_two
  end

  private

  attr_reader :board

  def start_loop
    loop
  end
end
