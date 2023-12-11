class Day11

  def solve(input, factor = 2)
    grid = []
    iterations = factor - 1

    input.split("\n").each do |row|
      row.chars.each_with_index do |char, x|
        grid[x] ||= []
        grid[x] << char
      end
    end

    x_expansions = []

    grid.length.times do |x|
      if grid[x].all? { |c| c == '.' }
        x_expansions << x
      end
    end

    y_expansions = []
    range = 0..(grid.length - 1)

    grid.first.length.times do |y|
      if range.map { |x| grid[x][y] }.all? { |c| c == '.' }
        y_expansions << y
      end
    end

    points = []

    grid.length.times do |x|
      grid.first.length.times do |y|
        points << [x, y] if grid[x][y] == '#'
      end
    end

    distances = []

    points.length.times do |index|
      p1 = points[index]

      points[(index + 1)..].each do |p2|
        x_range = Range.new(*[p1[0], p2[0]].sort)
        y_range = Range.new(*[p1[1], p2[1]].sort)

        x_count = x_expansions.count do |exp|
          x_range.include?(exp)
        end

        y_count = y_expansions.count do |exp|
          y_range.include?(exp)
        end

        d_x = (p1[0] - p2[0]).abs + (x_count * iterations)
        d_y = (p1[1] - p2[1]).abs + (y_count * iterations)

        distances << (d_x + d_y)
      end
    end

    distances.sum
  end

  def part1(input)
    solve(input)
  end

  def part2(input, factor = 1_000_000)
    solve(input, factor)
  end

end
