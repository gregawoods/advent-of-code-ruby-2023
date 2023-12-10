require 'colorize'

class Day10

  START = 'S'
  TOP_LEFT = 'F'
  TOP_RIGHT = '7'
  BOT_LEFT = 'L'
  BOT_RIGHT = 'J'
  HORIZONTAL = '-'
  VERTICAL = '|'

  # Point = Struct.new(:x, :y)

  def part1(input)
    grid = []

    input.split("\n").each do |row|
      row.chars.each_with_index do |char, x|
        grid[x] ||= []
        grid[x] << char
      end
    end

    path = []

    grid.each_with_index do |row, x|
      row.each_with_index do |point, y|
        if point == START
          path << [x, y]
          break
        end
      end
    end

    path << find_available_paths(grid, path.first).first

    loop do
      found = find_available_paths(grid, path.last).find { |pos| !path.include?(pos) }

      break if found.nil?

      path << found
    end

    # print_grid(grid, path)

    path.length / 2
  end

  COLORS = [:red, :yellow, :green, :cyan, :blue, :magenta]

  def print_grid(grid, path)
    grid.first.length.times do |y|
      grid.length.times do |x|
        char = grid[x][y]
        if path.include?([x, y])
          color = path.index([x, y]) % COLORS.length
          print char.send(COLORS[color])
        else
          print char
        end
      end
      print "\n"
    end
  end

  def find_available_paths(grid, position)
    paths = []

    current = grid[position[0]][position[1]]

    if (position[1] - 1) > -1 &&
       [TOP_LEFT, TOP_RIGHT, VERTICAL].include?(grid[position[0]][position[1] - 1]) &&
       [VERTICAL, BOT_LEFT, BOT_RIGHT, START].include?(current)
      # travels up
      paths << [position[0], position[1] - 1]
    end

    if (position[0] + 1) < grid.length &&
       [HORIZONTAL, TOP_RIGHT, BOT_RIGHT].include?(grid[position[0] + 1][position[1]]) &&
       [HORIZONTAL, BOT_LEFT, TOP_LEFT, START].include?(current)
      # travel right
      paths << [position[0] + 1, position[1]]
    end

    if (position[1] + 1 < grid.first.length) &&
       [VERTICAL, BOT_LEFT, BOT_RIGHT].include?(grid[position[0]][position[1] + 1]) &&
       [VERTICAL, TOP_LEFT, TOP_RIGHT, START].include?(current)
      # travel down
      paths << [position[0], position[1] + 1]
    end

    if (position[0] - 1) > -1 &&
       [HORIZONTAL, BOT_LEFT, TOP_LEFT].include?(grid[position[0] - 1][position[1]]) &&
       [HORIZONTAL, TOP_RIGHT, BOT_RIGHT, START].include?(current)
      # travel left
      paths << [position[0] - 1, position[1]]
    end

    paths
  end

  def part2(input)
    'TODO'
  end

end
