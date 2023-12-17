class Day14

  def parse(input)
    lines = input.split("\n")

    grid = []

    lines.length.times do |n|
      lines[n].chars.each_with_index do |char, i|
        grid[i] ||= []
        grid[i] << char
      end
    end

    grid
  end

  def calculate(grid)
    value = 0

    grid.each do |col|
      col.each_with_index do |obj, index|
        value += (col.length - index) if obj == 'O'
      end
    end

    value
  end

  def shift_column(column)
    new_column = column

    column.length.times do |n|
      next if n.zero?

      n.times do |i|
        position = n - i

        char = new_column[position]
        prev_char = new_column[position - 1]

        if char == 'O' && prev_char == '.'
          new_column[position] = '.'
          new_column[position - 1] = 'O'
        else
          break
        end
      end
    end

    new_column
  end

  def shift_grid(grid)
    grid.map do |column|
      shift_column(column)
    end
  end

  def rotate_clockwise(grid)
    new_grid = []

    grid.each do |column|
      column.reverse.each_with_index do |item, index|
        new_grid[index] ||= []
        new_grid[index] << item
      end
    end

    new_grid
  end

  def part1(input)
    calculate(shift_grid(parse(input)))
  end

  def part2(input)
    grid = parse(input)

    history = [grid.dup]

    iterations = 1_000_000_000

    iterations.times do |i|
      4.times do
        grid = rotate_clockwise(shift_grid(grid))
      end

      if history.include?(grid)
        loop_start_idx = history.index(grid)
        the_loop = history[loop_start_idx..]
        idx = ((iterations - i) % the_loop.length) - 1

        return calculate(the_loop[idx])
      end

      history << grid.map(&:dup)
    end

    raise 'Should not get this far!'
  end

end
