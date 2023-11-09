# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :board, :game_turn, :game_ended, :player_one, :player_two,
                :active_player, :player_color, :player_input

  def initialize
    @board = Board.new
    @game_turn = 0
    @game_ended = false
    @player_one = Player.new(1)
    @player_two = Player.new(2)
  end

  def start
    puts "Welcome to Connect Four! The player that wants to play with blue chips shall start!
To play, just enter a number ranging from 1 to 7 to place your chip in the specified column."

    loop until game_ended
  end

  def loop
    @active_player = (game_turn % 2).even? ? player_one : player_two
    @player_color = active_player.get_color(active_player.player_number)
    @player_input = active_player.get_input
    return if player_input.nil?

    exchange_data(player_input, player_color)
    game_state(board.winner)

    @game_turn += 1
  end

  private

  def exchange_data(player_input, player_color)
    board.update_board(player_input, player_color)
    board.print_board
  end

  def game_state(value)
    case value
    when :blue
      @game_ended = true
      puts "The game ended after #{game_turn} turns and with blue being the winner! Congratulations!"

    when :red
      @game_ended = true
      puts "The game ended after #{game_turn} turns and with red being the winner! Congratulations!"

    when 'No winner'
      nil
    end
  end
end
