class Day18

  Point = Data.define(:x, :y) do
    def at?(x, y)
      self.x == x && self.y == y
    end
  end

  UP = 'U'
  DOWN = 'D'
  LEFT = 'L'
  RIGHT = 'R'

  def part1(input)
    current = Point.new(0, 0)
    trench = [current]
    distance_traveled = 0

    input.split("\n").each do |line|
      direction, count, = line.split
      count = count.to_i
      distance_traveled += count

      case direction
      when UP
        current = Point.new(current.x, current.y - count)
        trench << current
      when DOWN
        current = Point.new(current.x, current.y + count)
        trench << current
      when LEFT
        current = Point.new(current.x - count, current.y)
        trench << current
      when RIGHT
        current = Point.new(current.x + count, current.y)
        trench << current
      end
    end

    calculate(trench) + (distance_traveled / 2) + 1
  end

  def calculate(points)
    s1 = 0
    (points.length - 1).times do |n|
      s1 += (points[n].x * points[n + 1].y)
    end

    s2 = 0
    (points.length - 1).times do |n|
      s2 += (points[n + 1].x * points[n].y)
    end

    (s1 - s2).abs / 2
  end

  MAPPING = {
    '0' => 'R',
    '1' => 'D',
    '2' => 'L',
    '3' => 'U'
  }

  def part2(input)
    current = Point.new(0, 0)
    trench = [current]
    distance_traveled = 0

    input.split("\n").each do |line|
      chunk = line.split('#').last
      direction = MAPPING[chunk[5]]
      count = chunk[0, 5].hex
      distance_traveled += count

      case direction
      when UP
        current = Point.new(current.x, current.y - count)
        trench << current
      when DOWN
        current = Point.new(current.x, current.y + count)
        trench << current
      when LEFT
        current = Point.new(current.x - count, current.y)
        trench << current
      when RIGHT
        current = Point.new(current.x + count, current.y)
        trench << current
      end
    end

    calculate(trench) + (distance_traveled / 2) + 1
  end
end
