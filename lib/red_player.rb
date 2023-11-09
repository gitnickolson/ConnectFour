# frozen_string_literal: true

require_relative 'player'

class RedPlayer < Player
  def initialize
    super
    @player_color = :red
  end
end
