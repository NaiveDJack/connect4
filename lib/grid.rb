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
    add_token(gets.chomp, value) unless validate_input(column)

    @tokens[:"c#{column}"][@tokens[:"c#{column}"].key(0)] = value
  end

  def validate_input(column)
    unless (1..7).include?(column)
      puts 'Invalid input, enter a number between 1 and 7'
      return false
    end

    unless @tokens[:"c#{column}"][:r6].zero?
      print 'column is full, available columns are'
      check_columns
      return false
    end

    true
  end

  def check_columns
    @tokens.each_value.with_index(1) do |column, index|
      print " #{index}" if column[:r6].zero?
    end
  end

  # prints the tokens in correct order with the ascii
  def show_grid
    puts('┌───┬───┬───┬───┬───┬───┬───┐')
    6.downto(1) do |row|
      print('│ ')
      @tokens.each_value do |column|
        print(column[:"r#{row}"], ' │ ')
      end
      row == 1 ? puts(' ', '└───┴───┴───┴───┴───┴───┴───┘') : puts(' ', '├───┼───┼───┼───┼───┼───┼───┤')
    end
  end
end
