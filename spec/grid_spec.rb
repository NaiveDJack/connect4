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

  describe '#same_four?' do
    context 'when prompted a quad with zeroes' do
      it 'returns false' do
        expect(grid.same_four?([0, 0, 0, 0])).to eq(false)
      end
    end

    context 'when prompted a line with no zeroes' do
      it 'returns true on a full line' do
        expect(grid.same_four?(['◉', '◉', '◉', '◉'])).to eq(true)
      end

      it 'returns false on an incomplete line' do
        expect(grid.same_four?(['◉', '◎', '◉', '◉'])).to eq(false)
      end
    end
  end

  describe '#line_slicer' do
    context 'when fed an array length 6' do
      it 'returns three arrays of length 4' do
        expect(grid.line_slicer([0, 0, 0, 0, 0, 0]).length).to eq(3)
      end
    end

    context 'when fed an array length 7' do
      it 'returns four arrays of length 4' do
        expect(grid.line_slicer([0, 0, 0, 0, 0, 0, 0]).length).to eq(4)
      end
    end

    context 'when fed an array length 3' do
      it 'returns no arrays' do
        expect(grid.line_slicer([0, 0, 0]).length).to eq(0)
      end
    end
  end

  # mock grids for testing line checkers

  let(:vert_mock) do
    { c1: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c2: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c3: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c4: { r1: '◎', r2: '◎', r3: '◎', r4: '◎', r5: 0, r6: 0 },
      c5: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c6: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c7: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 } }
  end

  let(:hori_mock) do
    { c1: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c2: { r1: '◎', r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c3: { r1: '◎', r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c4: { r1: '◎', r2: 0, r3: '◎', r4: '◎', r5: 0, r6: 0 },
      c5: { r1: '◎', r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c6: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c7: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 } }
  end

  let(:diag_mock) do
    { c1: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c2: { r1: '◎', r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c3: { r1: '◎', r2: '◎', r3: 0, r4: 0, r5: 0, r6: 0 },
      c4: { r1: 0, r2: 0, r3: '◎', r4: 0, r5: 0, r6: 0 },
      c5: { r1: '◎', r2: 0, r3: 0, r4: '◎', r5: 0, r6: 0 },
      c6: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c7: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 } }
  end

  describe '#vertical_line?' do
    context 'when there is a vertical line' do
      it 'returns true' do
        expect(grid.vertical_line?(vert_mock)).to eq(true)
      end
    end

    context 'when there is a horizontal line' do
      it 'returns false' do
        expect(grid.vertical_line?(hori_mock)).to eq(false)
      end
    end

    context 'when the grid is empty' do
      it 'returns false' do
        expect(grid.vertical_line?(grid.tokens)).to eq(false)
      end
    end
  end

  describe '#horizontal_line?' do
    context 'when there is an horizontal line' do
      it 'returns true' do
        expect(grid.horizontal_line?(hori_mock)).to eq(true)
      end
    end

    context 'when there is a vertical line' do
      it 'returns false' do
        expect(grid.horizontal_line?(vert_mock)).to eq(false)
      end
    end

    context 'when there is a diagonal line' do
      it 'returns false' do
        expect(grid.horizontal_line?(diag_mock)).to eq(false)
      end
    end

    context 'when the grid is empty' do
      it 'returns false' do
        expect(grid.horizontal_line?(grid.tokens)).to eq(false)
      end
    end
  end

  describe '#diagonal_line?' do
    context 'when there is an horizontal line' do
      it 'returns false' do
        expect(grid.diagonal_line?(hori_mock)).to eq(false)
      end
    end

    context 'when there is a vertical line' do
      it 'returns false' do
        expect(grid.diagonal_line?(vert_mock)).to eq(false)
      end
    end

    context 'when there is a diagonal line' do
      it 'returns true' do
        expect(grid.diagonal_line?(diag_mock)).to eq(true)
      end
    end

    context 'when the grid is empty' do
      it 'returns false' do
        expect(grid.diagonal_line?(grid.tokens)).to eq(false)
      end
    end
  end

  describe '#full?' do
    context "when grid's columns are all filled" do
      it 'returns true' do
        grid.tokens.each.with_index(1) do |_column, index|
          6.times { grid.add_token(index, '◉') }
        end
        expect(grid.full?).to eq(true)
      end
    end

    context 'when grid is not completely filled' do
      it 'returns false' do
        expect(grid.full?).to eq(false)
      end
    end
  end

  describe '#win?' do
    context 'when a winning line is in grid' do
      it 'returns true' do
        expect(grid.win?(hori_mock)).to eq(true)
      end
    end
  end

  describe '#show_grid' do
    context 'anytime' do
      it 'shows the grid' do
        grid.show_grid
      end
    end
  end
end
