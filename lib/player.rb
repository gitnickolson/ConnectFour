# frozen_string_literal: true

class Player
  def get_color(number)
    if number == 1
      :blue
    elsif number == 2
      :red
    end
  end
end
