# frozen_string_literal: true

require_relative 'player'

class RedPlayer < Player
  def initialize
    super
    @color = :red
  end
end
