module Util
  def parse_grid(input, fn = nil)
    lines = input.split("\n")
    grid = []

    lines.length.times do |n|
      lines[n].chars.each_with_index do |char, i|
        grid[i] ||= []
        grid[i] << (fn ? char.send(fn) : char)
      end
    end

    grid
  end

  def print_grid(grid)
    grid.first.length.times do |y|
      grid.length.times do |x|
        print grid[x][y]
      end
      print "\n"
    end
  end

  def percent(x, y)
    "#{(x / y.to_f * 100).round(1)}%"
  end
end
