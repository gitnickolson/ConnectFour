# frozen_string_literal: true

require_relative 'blue_player'
require_relative 'red_player'
require_relative 'board'

class Game
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

  private

  attr_reader :board, :player_input, :turn, :active_player, :player_one, :player_two

  def loop
    @active_player = (turn % 2).even? ? player_one : player_two
    player_input = active_player.get_input

    case board.update(player_input, active_player.color)
    when nil
      puts "Error: You can't place any more chips in this column"
    else
      board.print
      @turn += 1
    end
  end

  def start_loop
    loop until ended?
  end

  def ended?
    case board.winner
    when :blue
      puts 'Congratulations! Blue won!'
      true
    when :red
      puts 'Congratulations! Red won!'
      true
    when :tie
      puts "Oh no! It's a tie!"
      true
    else
      false
    end
  end
end
