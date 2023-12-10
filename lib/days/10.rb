require 'colorize'

class Day10

  START = 'S'
  UP_RIGHT = 'F'
  UP_LEFT = '7'
  DOWN_RIGHT = 'L'
  DOWN_LEFT = 'J'
  HORIZONTAL = '-'
  VERTICAL = '|'

  def parse(input)
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

    [grid, path]
  end

  def part1(input)
    _grid, path = parse(input)

    path.length / 2
  end

  COLORS = [:red, :yellow, :green, :cyan, :blue, :magenta]

  def print_grid(grid, path, free_cells = [])
    grid.first.length.times do |y|
      strings = grid.length.times.map do |x|
        char = grid[x][y]
        if path.include?([x, y])
          color = path.index([x, y]) % COLORS.length
          char.send(COLORS[color])
        elsif char == '*'
          char.grey
        elsif free_cells.include?([x, y])
          'O'.light_white
        else
          'I'.colorize(color: :white, mode: :bold, background: :light_blue)
        end
      end
      puts strings.join
    end
  end

  def find_available_paths(grid, position)
    paths = []

    current = grid[position[0]][position[1]]

    if (position[1] - 1) > -1 &&
       [UP_RIGHT, UP_LEFT, VERTICAL].include?(grid[position[0]][position[1] - 1]) &&
       [VERTICAL, DOWN_RIGHT, DOWN_LEFT, START].include?(current)
      # travels up
      paths << [position[0], position[1] - 1]
    end

    if (position[0] + 1) < grid.length &&
       [HORIZONTAL, UP_LEFT, DOWN_LEFT].include?(grid[position[0] + 1][position[1]]) &&
       [HORIZONTAL, DOWN_RIGHT, UP_RIGHT, START].include?(current)
      # travel right
      paths << [position[0] + 1, position[1]]
    end

    if (position[1] + 1 < grid.first.length) &&
       [VERTICAL, DOWN_RIGHT, DOWN_LEFT].include?(grid[position[0]][position[1] + 1]) &&
       [VERTICAL, UP_RIGHT, UP_LEFT, START].include?(current)
      # travel down
      paths << [position[0], position[1] + 1]
    end

    if (position[0] - 1) > -1 &&
       [HORIZONTAL, DOWN_RIGHT, UP_RIGHT].include?(grid[position[0] - 1][position[1]]) &&
       [HORIZONTAL, UP_LEFT, DOWN_LEFT, START].include?(current)
      # travel left
      paths << [position[0] - 1, position[1]]
    end

    paths
  end

  def build_2x(grid, path)
    @grid = []

    # puts '🛠️ Building 2x grid...'
    grid.length.times do |x|
      grid.first.length.times do |y|
        @grid[(x * 2)] ||= []
        @grid[(x * 2) + 1] ||= []
        @grid[x * 2][y * 2] = grid[x][y]
        @grid[(x * 2) + 1][y * 2] = '*'
        @grid[(x * 2) + 1][(y * 2) + 1] = '*'
        @grid[(x * 2)][(y * 2) + 1] = '*'
      end
    end

    # puts '🛠️ Building 2x path...'
    @path = []
    path.each_with_index do |step, index|
      @path << [
        step[0] * 2, step[1] * 2
      ]

      a_x = path[index][0]
      a_y = path[index][1]

      if path[index + 1]
        b_x = path[index + 1][0]
        b_y = path[index + 1][1]
      else
        b_x = path[0][0]
        b_y = path[0][1]
      end

      d_x = b_x - a_x
      d_y = b_y - a_y

      @path << [
        (step[0] * 2) + d_x,
        (step[1] * 2) + d_y
      ]
    end
  end

  def part2(input)
    @visited = Set.new

    grid, path = parse(input)

    build_2x(grid, path)

    @grid_width = @grid.length
    @grid_height = @grid.first.length

    @free_cells = Set.new

    cells_to_check = []

    @grid_width.times do |x|
      cells_to_check << [x, 0]
      cells_to_check << [x, @grid.first.length - 1]
    end

    @grid_height.times do |y|
      cells_to_check << [0, y]
      cells_to_check << [@grid.length - 1, y]
    end

    cells_to_check.uniq!.reject! do |c|
      @path.include?(c)
    end

    loop do
      cells_to_check = cells_to_check.map do |n|
        check_cell(n)
      end

      cells_to_check = cells_to_check.compact.flatten(1).uniq.reject { @free_cells.include?(_1) }

      break if cells_to_check.none?
    end

    count = 0

    # puts '💯 Counting results'

    @grid.first.length.times do |y|
      @grid.length.times do |x|
        count += 1 if @grid[x][y] != '*' && !@path.include?([x, y]) && !@free_cells.include?([x, y])
      end
    end

    print_grid(@grid, @path, @free_cells)

    count
  end

  def check_cell(point)
    @free_cells << point

    neighbor_points(point).reject do |n|
      @free_cells.include?(n) || @path.include?(n)
    end
  end

  def neighbor_points(point)
    points = []

    points << [point[0] - 1, point[1]] if point[0].positive?
    points << [point[0], point[1] - 1] if point[1].positive?
    points << [point[0] + 1, point[1]] if point[0] + 1 < @grid_width
    points << [point[0], point[1] + 1] if point[1] + 1 < @grid_height

    points.reject { |p| @path.include?(p) }
  end
end
