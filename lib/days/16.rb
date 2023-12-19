class Day16
  include Util

  MIRROR_LEFT = '\\'
  MIRROR_RIGHT = '/'
  SPLIT_VERT = '|'
  SPLIT_HORI = '-'

  MOVEMENTS = {
    up: [0, -1],
    down: [0, 1],
    right: [1, 0],
    left: [-1, 0]
  }

  Beam = Data.define(:x, :y, :dir) do
    def move(dir)
      mv = MOVEMENTS[dir]
      Beam.new(x + mv[0], y + mv[1], dir)
    end

    def pos
      [x, y]
    end
  end

  def part1(input)
    grid = parse_grid(input)

    solve(grid, Beam.new(0, 0, :right))
  end

  def part2(input)
    grid = parse_grid(input)

    values = []

    grid.length.times do |x|
      values << solve(grid, Beam.new(x, 0, :down))
      values << solve(grid, Beam.new(x, grid.first.length - 1, :up))
    end

    grid.first.length.times do |y|
      values << solve(grid, Beam.new(0, y, :right))
      values << solve(grid, Beam.new(grid.length - 1, y, :right))
    end

    values.max
  end

  def solve(grid, initial)
    visited = Set.new
    beams = [initial]

    loop do
      new_beams = []

      beams.each do |beam|
        if beam.x.negative? ||
           beam.x >= grid.length ||
           beam.y.negative? ||
           beam.y >= grid.first.length ||
           visited.include?(beam)
          next
        end

        visited.add(beam)

        case grid[beam.x][beam.y]
        when MIRROR_LEFT
          case beam.dir
          when :up
            new_beams << beam.move(:left)
          when :down
            new_beams << beam.move(:right)
          when :left
            new_beams << beam.move(:up)
          when :right
            new_beams << beam.move(:down)
          end
        when MIRROR_RIGHT
          case beam.dir
          when :up
            new_beams << beam.move(:right)
          when :down
            new_beams << beam.move(:left)
          when :left
            new_beams << beam.move(:down)
          when :right
            new_beams << beam.move(:up)
          end
        when SPLIT_HORI
          if [:up, :down].include?(beam.dir)
            new_beams << beam.move(:left)
            new_beams << beam.move(:right)
          else
            new_beams << beam.move(beam.dir)
          end
        when SPLIT_VERT
          if [:left, :right].include?(beam.dir)
            new_beams << beam.move(:up)
            new_beams << beam.move(:down)
          else
            new_beams << beam.move(beam.dir)
          end
        else
          new_beams << beam.move(beam.dir)
        end
      end

      break if new_beams.empty?

      beams = new_beams
    end

    visited.map(&:pos).uniq.length
  end

end
