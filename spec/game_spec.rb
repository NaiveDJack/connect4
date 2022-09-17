# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/grid'

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
        expect(mock_turn[:player].name).to eq('dan')
      end
    end

    context 'when turn[counter] is even' do
      let(:mock_turn) { { player: 'none', counter: 2 } }
      it 'sets turn[player] to player 2' do
        game.turn_assign(mock_turn, mock_p1, mock_p2)
        expect(mock_turn[:player].name).to eq('fred')
      end
    end
  end

  describe '#state_check' do
    let(:grid) { instance_double(Grid) }
    let(:mock_turn) { { player: 'none', counter: 2 } }

    context 'when a win is detected' do
      before do
        allow(grid).to receive(:full?).and_return(false)
        allow(grid).to receive(:win?).and_return(true)
      end

      it 'changes @state to won' do
        expect { game.state_check(grid) }.to change(game, :state).from('on').to('won')
        game.state_check(grid)
      end
    end

    context 'when the grid is full' do
      before do
        allow(grid).to receive(:full?).and_return(true)
      end

      it 'changes @state to tie' do
        expect { game.state_check(grid) }.to change(game, :state).from('on').to('tie')
      end
    end

    context 'when no win is detected and grid is not full' do
      before do
        allow(grid).to receive(:full?).and_return(false)
        allow(grid).to receive(:win?).and_return(false)
      end

      it 'adds 1 to turn counter and @state remains on' do
        expect { game.state_check(grid, mock_turn) }.to change { mock_turn[:counter] }.by(1)
        expect(game.state).to be('on')
        game.state_check(grid, mock_turn)
      end
    end
  end
end
