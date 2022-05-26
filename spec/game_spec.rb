# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  # starts the game
  describe '#initialize' do
    context 'when class Game is initialized' do
      it 'sets the game state to on' do
        expect(game.state).to be('on')
      end
    end
  end

  # setup functions testing 

  # requests player 1 and player 2 names
  describe '#player_setup' do
    context 'when setup is done' do
      it 'assigns a value to p1 and p2' do
        game.player_setup
        expect(game.p1).not_to be_nil
        expect(game.p2).not_to be_nil
      end
    end
  end
  # creates the grid
  describe '#grid_setup' do
    context 'when setup is done' do
      it 'shows a grid' do
        game.grid_setup
        game.grid.show_grid
      end
    end
  end

  # play functions testing

  # checks the turn number and assigns it to a player accordingly
  describe '#turn_assign' do
    let(:mock_p1) { double('player', name: 'dan') }
    let(:mock_p2) { double('player', name: 'fred') }

    context 'when turn[counter] is odd' do
      let(:mock_turn) { { player: 'none', counter: 1 } }
      it 'sets turn[player] to player 1' do
        game.turn_assign(mock_turn, mock_p1, mock_p2)
        expect(mock_turn[:player]).to eq('dan')
      end
    end

    context 'when turn[counter] is even' do
      let(:mock_turn) { { player: 'none', counter: 2 } }
      it 'sets turn[player] to player 2' do
        game.turn_assign(mock_turn, mock_p1, mock_p2)
        expect(mock_turn[:player]).to eq('fred')
      end
    end
  end

  # calls grid.add_token based on turn[player]
  # updates turn[number] by 1
  describe '#turn_play' do
    context 'when a turn starts' do
      let(:mock_turn) { { player: 'dan', counter: 1 } }

      it 'updates the turn counter by one' do
        expect { game.turn_play(mock_turn) }.to change { mock_turn[:counter] }.from(1).to(2)
      end
    end
  end

  describe '#player_input' do
    context 'when game is on' do
      it 'defines selected_column' do
        game.player_input
        expect(selected_column).not_to be_nil
      end

      it 'calls Grid.add_token'
      it 'calls Grid.add_token again if column is full'
    end
  end

  describe '#check_state' do
    context 'when game is won' do
      it 'gives victory to the active player'
      it 'sets the game to off'
    end

    context 'when grid is full' do
      it 'sets game to off'
    end
  end
  # outputs error if add token == nil
  # check game state
  # correctly identifies win state
  # correctly identifies tie state (all columns are full)
  # else game == on 
end
