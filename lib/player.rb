# frozen_string_literal: true

# creates a player with a name, a position, and a token
class Player
  attr_reader :name

  def initialize(number)
    @name = gets.chomp
    @token = assign_side(number)
  end

  def assign_side(number)
    case number
    when 1
      '◎'
    when 2
      '◉'
    end
  end
end
