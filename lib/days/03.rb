class Day03

  Point = Struct.new(:x, :y, :value) do
    def points
      value.to_s.length.times.map { |i| [x + i, y] }
    end

    def next_to?(in_x, in_y)
      points.any? do |x, y|
        (x - in_x).abs <= 1 && (y - in_y).abs <= 1
      end
    end
  end

  def parse(input)
    operations = []
    numbers = []

    input.split("\n").each_with_index do |line, index|
      line.enum_for(:scan, /\d+|[^\.]/).map { |m| [m, Regexp.last_match.begin(0)] }.each do |match, pos|
        if match.match?(/\d+/)
          numbers << Point.new(pos, index, match.to_i)
        else
          operations << Point.new(pos, index, match)
        end
      end
    end

    [operations, numbers]
  end

  def part1(input)
    operations, numbers = parse(input)

    numbers.select do |num|
      operations.any? do |op|
        num.next_to?(op.x, op.y)
      end
    end.sum(&:value)
  end

  def part2(input)
    operations, numbers = parse(input)
    values = []

    operations.select { |op| op.value == '*' }.each do |operation|
      neighors = numbers.select { |num| num.next_to?(operation.x, operation.y) }

      values << (neighors.first.value * neighors.last.value) if neighors.length == 2
    end

    values.sum
  end

end
