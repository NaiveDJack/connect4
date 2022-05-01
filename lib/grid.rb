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

  # value will be externally restricted to 1, 2 or colored things
  def add_token(column, value)
    return if @tokens[:"c#{column}"][@tokens[:"c#{column}"].key(0)].nil?

    @tokens[:"c#{column}"][@tokens[:"c#{column}"].key(0)] = value
  end

  # prints the tokens in correct order with the ascii
  def show_grid
    puts('┌───┬───┬───┬───┬───┬───┬───┐')
    6.downto(1) do |row|
      print( '│ ')
      @tokens.each_value do |column|
        print(column[:"r#{row}"], ' │ ')
      end
      row == 1 ? puts(' ', '└───┴───┴───┴───┴───┴───┴───┘') : puts(' ', '├───┼───┼───┼───┼───┼───┼───┤')
    end
  end
end
