# frozen_string_literal: true

# grid for connect 4
class Grid
  attr_reader :tokens

  def initialize
    @tokens = {
      c1: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c2: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c3: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c4: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c5: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c6: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 },
      c7: { r1: 0, r2: 0, r3: 0, r4: 0, r5: 0, r6: 0 }
    }
  end

  def add_token(column, value)
    return if @tokens[:"c#{column}"][@tokens[:"c#{column}"].key(0)].nil?

    @tokens[:"c#{column}"][@tokens[:"c#{column}"].key(0)] = value
  end

  # prints the tokens in correct order with the ascii
  def show_grid
    for i in 6..0 do
      @tokens.each_value { |column| print(column[:"c#{i}"], ┃ ) }
    end
    # X = 6 until X = 0
    # for each value in @tokens
    # print r#{X}
    # X -= 1
  end
end
