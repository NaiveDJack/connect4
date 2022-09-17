# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'

# base Game mechanics
class Game
  attr_reader :state, :p1, :p2, :grid, :turn

  def initialize
    @state = 'on'
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
    @turn = { player: @p1, counter: 1 }
  end

  # game flow functions

  # main game flow
  def game_play
    turn_play while @state == 'on'
    puts('game over!', @state)
    puts("the winner is #{turn[:player].name}") if @state == 'won'
    puts('the game is tied!') if @state == 'tie'
  end

  # single turn flow
  def turn_play(turn = @turn)
    turn_assign(turn, @p1, @p2)
    @grid.show_grid
    player_input
    @grid.show_grid
    state_check
  end

  def turn_assign(turn = @turn, p1 = @p1, p2 = @p2)
    turn[:player] = turn[:counter].odd? ? p1 : p2
    puts("it's #{turn[:player].name}'s turn.")
  end

  def player_input
    puts('Select the column where you want to put the token.')
    @grid.add_token(gets.chomp.to_i, @turn[:player].token)
  end

  # game state checkers
  def state_check(grid = @grid, turn = @turn)
    if grid.full?
      @state = 'tie'
    elsif grid.win?
      @state = 'won'
    else
      turn[:counter] += 1
    end
  end
end
