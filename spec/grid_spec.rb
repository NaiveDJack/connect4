# frozen_string_literal: true

require_relative './../lib/grid'

describe Grid do
  subject(:grid) { described_class.new }

  describe '#add_token' do
    context 'when you add a token' do
      it 'substitutes the first zero in the correct column' do
        grid.add_token(1, 1)
        expect(grid.tokens[:c1][:r1]).to eq(1)
        expect(grid.tokens[:c2][:r1]).to eq(0)
      end
    end
  end

  describe '#validate_input' do
    context 'when input is not 1..7' do
      it 'returns false' do
        expect(grid.validate_input('a')).to eq(false)
      end
    end
    context 'when input is valid but column is full' do
      it 'returns false' do
        6.times { grid.add_token(3, 1) }
        expect(grid.validate_input(3)).to eq(false)
      end
    end
    context 'when input is valid' do
      it 'returns true' do
        expect(grid.validate_input(5)).to eq(true)
      end
    end
  end

  describe '#show_grid' do
    it 'shows the grid' do
      grid.show_grid
    end
  end
end
