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

  # token will be externally restricted to 1, 2 or colored things
  def add_token(column, token)
    add_token(gets.chomp.to_i, token) unless validate_input(column)

    @tokens[:"c#{column}"][@tokens[:"c#{column}"].key(0)] = token
  end

  def validate_input(column)
    unless (1..7).include?(column)
      puts 'Invalid input, enter a number between 1 and 7'
      return false
    end

    unless @tokens[:"c#{column}"][:r6].ord.zero?
      print 'column is full, available columns are'
      check_columns
      return false
    end

    true
  end

  def check_columns
    @tokens.each_value.with_index(1) do |column, index|
      print " #{index}" if column[:r6].ord.zero?
    end

    puts
  end

  # checking grid state game wise

  def win?(grid = @tokens)
    [vertical_line?(grid), horizontal_line?(grid), diagonal_line?(grid)].any? ? true : false
  end

  def full?(grid = @tokens)
    grid.none? { |_column, row| row[:r6].ord.zero? }
  end

  def same_four?(quad)
    return false if quad.include?(0)
    return true if quad.uniq.length == 1

    false
  end

  def line_slicer(line)
    fours = []
    (0..line.length - 4).each { |starter| fours += [line.slice(starter, 4)] }
    fours
  end

  def vertical_line?(grid = @tokens)
    grid.each_value do |column|
      v_line = column.values
      v_fours = line_slicer(v_line)
      return true if v_fours.any? { |quad| true if same_four?(quad) }
    end
    false
  end

  def horizontal_line?(grid = @tokens)
    (0..5).each do |row|
      h_line = []
      grid.each_value { |column| h_line << column.values[row] }
      h_fours = line_slicer(h_line)
      return true if h_fours.any? { |quad| true if same_four?(quad) }
    end
    false
  end

  def diagonal_line?(grid = @tokens)
    (1..4).each { |column| (1..3).each { |row| return true if rw_diag_line?(grid, column, row) } }
    (4..7).each { |column| (1..3).each { |row| return true if lw_diag_line?(grid, column, row) } }
    false
  end

  def rw_diag_line?(grid, column, row)
    diag_quad = [
      grid[:"c#{column}"][:"r#{row}"],
      grid[:"c#{column + 1}"][:"r#{row + 1}"],
      grid[:"c#{column + 2}"][:"r#{row + 2}"],
      grid[:"c#{column + 3}"][:"r#{row + 3}"]
    ]
    same_four?(diag_quad) ? true : false
  end

  def lw_diag_line?(grid, column, row)
    diag_quad = [
      grid[:"c#{column}"][:"r#{row}"],
      grid[:"c#{column - 1}"][:"r#{row + 1}"],
      grid[:"c#{column - 2}"][:"r#{row + 2}"],
      grid[:"c#{column - 3}"][:"r#{row + 3}"]
    ]
    same_four?(diag_quad) ? true : false
  end

  # visualization method
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
