# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :player, :board, :player_number, :game_turn, :game_ended

  def initialize
    @player = Player.new
    @board = Board.new
    @player_number = 1
    @game_turn = 0
    @game_ended = false
  end

  def start
    board.print_board
    puts 'Welcome to "Connect Four"! The player that wants to play with blue chips shall start!'
    puts 'To play, just enter a number ranging from 1 to 7 to place your chip in the specified column.'

    game_loop until game_ended
  end

  def game_loop
    player_number = (game_turn % 2).even? ? 1 : 2

    player_color = player.get_color(player_number)
    player_input = gets.chomp.to_i
    check_input(player_input)

    update_return_value = board.update_board(player_input, player_color)
    game_state(update_return_value)

    @game_turn += 1
  end

  def game_state(value)
    case value
    when :blue
      @game_ended = true
      puts "The game ended after #{game_turn} turns and with blue being the winner! Congratulations!"

    when :red
      @game_ended = true
      puts "The game ended after #{game_turn} turns and with red being the winner! Congratulations!"

    when 'Error'
      nil
    end
  end

  def check_input(input)
    return if (1..7).include?(input)

    puts 'Error: Please enter a number ranging from 1 to 7'
    game_loop
  end
end
