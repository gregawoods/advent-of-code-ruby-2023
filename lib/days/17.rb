class Day17
  require 'fc'
  include Util

  RIGHT = :right
  LEFT = :left
  DOWN = :down
  UP = :up

  Crucible = Struct.new(
    :x, :y, :cost, :dir, :moves_in_dir
  ) do

    def pos
      [x, y]
    end
  end

  def part1(input)
    grid = parse_grid(input, :to_i)
    goal = [grid.length - 1, grid.first.length - 1]

    queue = FastContainers::PriorityQueue.new(:min)
    queue.push(Crucible.new(0, 0, 0, nil, 0), 0)
    visited = Set.new

    loop do
      crucible = queue.top
      queue.pop

      return crucible.cost if crucible.pos == goal

      next_steps = available_moves(grid, crucible.pos, crucible.cost, crucible.dir, crucible.moves_in_dir)

      next_steps.each do |next_step|
        hash = [next_step.pos, next_step.dir, next_step.moves_in_dir]
        next if visited.include?(hash)

        visited.add(hash)
        queue.push(next_step, next_step.cost)
      end

      break if queue.none?
    end
  end

  def available_moves(grid, position, current_cost, current_direction, num_direction)
    moves = []

    if position[1] != grid.first.length - 1 &&
       current_direction != UP &&
       !(current_direction == DOWN && num_direction >= 3)

      moves << Crucible.new(
        position[0],
        position[1] + 1,
        current_cost + grid[position[0]][position[1] + 1],
        DOWN,
        current_direction == DOWN ? num_direction + 1 : 1)
    end

    if !position[1].zero? &&
       current_direction != DOWN &&
       !(current_direction == UP && num_direction >= 3)

      moves << Crucible.new(
        position[0],
        position[1] - 1,
        current_cost + grid[position[0]][position[1] - 1],
        UP,
        current_direction == UP ? num_direction + 1 : 1)
    end

    if position[0] != grid.length - 1 &&
       current_direction != LEFT &&
       !(current_direction == RIGHT && num_direction >= 3)

      moves << Crucible.new(
        position[0] + 1,
        position[1],
        current_cost + grid[position[0] + 1][position[1]],
        RIGHT,
        current_direction == RIGHT ? num_direction + 1 : 1)
    end

    if !position[0].zero? &&
       current_direction != RIGHT &&
       !(current_direction == LEFT && num_direction >= 3)

      moves << Crucible.new(
        position[0] - 1,
        position[1],
        current_cost + grid[position[0] - 1][position[1]],
        LEFT,
        current_direction == LEFT ? num_direction + 1 : 1)
    end

    moves
  end

  def part2(input)
    grid = parse_grid(input, :to_i)
    goal = [grid.length - 1, grid.first.length - 1]

    queue = FastContainers::PriorityQueue.new(:min)
    queue.push(Crucible.new(0, 0, 0, nil, 0), 0)

    visited = Set.new

    loop do
      crucible = queue.top
      queue.pop

      return crucible.cost if crucible.pos == goal && crucible.moves_in_dir >= 4

      next_steps = available_moves_v2(grid, crucible.pos, crucible.cost, crucible.dir, crucible.moves_in_dir)

      next_steps.each do |next_step|
        hash = [next_step.pos, next_step.dir, next_step.moves_in_dir]
        next if visited.include?(hash)

        visited.add(hash)
        queue.push(next_step, next_step.cost)
      end

      break if queue.none?
    end
  end

  def available_moves_v2(grid, position, current_cost, current_direction, num_direction)
    moves = []

    if position[1] != grid.first.length - 1 &&
       current_direction != UP &&
       !([RIGHT, LEFT].include?(current_direction) && num_direction < 4) &&
       !(current_direction == DOWN && num_direction >= 10)

      moves << Crucible.new(
        position[0],
        position[1] + 1,
        current_cost + grid[position[0]][position[1] + 1],
        DOWN,
        current_direction == DOWN ? num_direction + 1 : 1)
    end

    if !position[1].zero? &&
       current_direction != DOWN &&
       !([RIGHT, LEFT].include?(current_direction) && num_direction < 4) &&
       !(current_direction == UP && num_direction >= 10)

      moves << Crucible.new(
        position[0],
        position[1] - 1,
        current_cost + grid[position[0]][position[1] - 1],
        UP,
        current_direction == UP ? num_direction + 1 : 1)
    end

    if position[0] != grid.length - 1 &&
       current_direction != LEFT &&
       !([UP, DOWN].include?(current_direction) && num_direction < 4) &&
       !(current_direction == RIGHT && num_direction >= 10)

      moves << Crucible.new(
        position[0] + 1,
        position[1],
        current_cost + grid[position[0] + 1][position[1]],
        RIGHT,
        current_direction == RIGHT ? num_direction + 1 : 1)
    end

    if !position[0].zero? &&
       current_direction != RIGHT &&
       !([UP, DOWN].include?(current_direction) && num_direction < 4) &&
       !(current_direction == LEFT && num_direction >= 10)

      moves << Crucible.new(
        position[0] - 1,
        position[1],
        current_cost + grid[position[0] - 1][position[1]],
        LEFT,
        current_direction == LEFT ? num_direction + 1 : 1)
    end

    moves
  end

end
