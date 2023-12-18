class Day18

  Point = Data.define(:x, :y) do
    def at?(x, y)
      self.x == x && self.y == y
    end

    def neighbors
      [
        Point.new(x - 1, y),
        Point.new(x + 1, y),
        Point.new(x, y - 1),
        Point.new(x, y + 1)
      ]
    end
  end

  GridInfo = Data.define(:min_x, :max_x, :min_y, :max_y) do
    def valid?(x, y)
      x >= min_x && x <= max_x && y >= min_y && y <= max_y
    end

    def size
      (max_x - min_x + 1) * (max_y - min_y + 1)
    end
  end

  UP = 'U'
  DOWN = 'D'
  LEFT = 'L'
  RIGHT = 'R'

  def part1(input)
    trench = Set.new
    current = Point.new(0, 0)
    trench.add(current)

    input.split("\n").each do |line|
      direction, count, = line.split
      count = count.to_i

      case direction
      when UP
        count.times do
          current = Point.new(current.x, current.y - 1)
          trench.add current
        end
      when DOWN
        count.times do
          current = Point.new(current.x, current.y + 1)
          trench.add current
        end
      when LEFT
        count.times do
          current = Point.new(current.x - 1, current.y)
          trench.add current
        end
      when RIGHT
        count.times do
          current = Point.new(current.x + 1, current.y)
          trench.add current
        end
      end
    end

    info = GridInfo.new(
      trench.map(&:x).min,
      trench.map(&:x).max,
      trench.map(&:y).min,
      trench.map(&:y).max
    )

    outside = Set.new

    (info.min_x..info.max_x).each do |x|
      (info.min_y..info.max_y).each do |y|
        point = Point.new(x, y)

        if (x == info.min_x || y == info.min_y || x == info.max_x || y == info.max_y) && !trench.include?(point)
          outside.add(point)
        end
      end
    end

    points_to_check = outside.map(&:neighbors).flatten.uniq

    loop do
      new_points_to_check = []

      points_to_check.each do |p|
        if !trench.include?(p) && !outside.include?(p) && info.valid?(p.x, p.y)
          outside.add(p)
          new_points_to_check += p.neighbors
        end
      end

      points_to_check = new_points_to_check

      break if points_to_check.empty?
    end

    info.size - outside.size
  end

  def draw_grid(info, trench, outside)
    (info.min_x..info.max_x).each do |x|
      (info.min_y..info.max_y).each do |y|
        if trench.include?(Point.new(x, y))
          print '#'.red
        elsif outside.include?(Point.new(x, y))
          print 'O'.blue
        else
          print '.'
        end
      end
      print "\n"
    end
  end

  def part2(input)
    'TODO'
  end

end
