# frozen_string_literal: true

class Player
  attr_reader :color

  def get_input
    loop do
      input = gets.chomp.to_i
      return input if number_valid?(input)

      puts 'Error: Please enter a valid integer number ranging from 1 to 7'
    end
  end

  private

  def number_valid?(input)
    (1..7).include?(input)
  end
end
