# frozen_string_literal: true

require_relative 'player'

class BluePlayer < Player
  def initialize
    super
    @color = :blue
  end
end
