# frozen_string_literal: true

class Player
  attr_accessor :player_number

  def initialize(player_number)
    @player_number = player_number
  end

  def get_color(number)
    return unless is_number_valid?(number)

    if number == 1
      :blue
    elsif number == 2
      :red
    end
  end

  def get_input
    input = gets.chomp.to_i
    return input if is_number_valid?(input) == true

    puts 'Error: Please enter a number ranging from 1 to 7'
    nil
  end

  private

  def is_number_valid?(input)
    return true if (1..7).include?(input)

    false
  end
end
