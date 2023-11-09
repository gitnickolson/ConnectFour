# frozen_string_literal: true

require_relative 'player'

class BluePlayer < Player
  def initialize
    super
    @player_color = :blue
  end
end
