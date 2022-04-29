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

      it 'returns nil when column is full' do
        6.times { grid.add_token(1, 1) }
        expect(grid.add_token(1, 1)).to be_nil
      end
    end
  end

  describe '#show_grid' do
    it 'shows the grid' do
      grid.show_grid
    end
  end
end
