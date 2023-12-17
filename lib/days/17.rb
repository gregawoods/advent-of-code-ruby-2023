class Day17
  require 'fc'
  include Util

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
    queue.push(Crucible.new(0, 0, 0, :down, 0), 0)
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

  LEFT_TO_RIGHT = :right
  RIGHT_TO_LEFT = :left
  DOWN = :down
  UP = :up

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
       current_direction != RIGHT_TO_LEFT &&
       !(current_direction == LEFT_TO_RIGHT && num_direction >= 3)

      moves << Crucible.new(
        position[0] + 1,
        position[1],
        current_cost + grid[position[0] + 1][position[1]],
        LEFT_TO_RIGHT,
        current_direction == LEFT_TO_RIGHT ? num_direction + 1 : 1)
    end

    if !position[0].zero? &&
       current_direction != LEFT_TO_RIGHT &&
       !(current_direction == RIGHT_TO_LEFT && num_direction >= 3)

      moves << Crucible.new(
        position[0] - 1,
        position[1],
        current_cost + grid[position[0] - 1][position[1]],
        RIGHT_TO_LEFT,
        current_direction == RIGHT_TO_LEFT ? num_direction + 1 : 1)
    end

    moves
  end

  def part2(_input)
    'TODO'
  end

end
