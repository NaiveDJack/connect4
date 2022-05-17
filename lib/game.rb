# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'

# base Game mechanics
class Game
  attr_reader :state, :p1, :p2, :grid, :turn

  def initialize
    @state = 'running'
  end

  # game setup functions
  def game_setup
    player_setup
    grid_setup
    turn_setup
  end

  def player_setup
    puts("Please input player 1's name")
    @p1 = Player.new(1)
    puts("Please input player 2's name")
    @p2 = Player.new(2)
  end

  def grid_setup
    @grid = Grid.new
  end

  def turn_setup
    @turn = { player: @p1.name, counter: 1 }
  end

  # game flow functions
  def turn_assign(turn = @turn, p1 = @p1, p2 = @p2)
    turn[:player] = turn[:counter].odd? ? p1.name : p2.name
  end

  def turn_play(turn = @turn)
    puts("it's #{turn[:player]}'s turn.")
    # play_turn
    turn[:counter] += 1
  end

  def play_turn
    puts('Select the column where you want to put the token.')
    # take and validate the input = new function?
    selected_column = gets.chomp
    @grid.add_token(selected_column, @turn[:player].token)
  end
  # game state checkers
end
