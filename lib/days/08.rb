class Day08

  def parse(input)
    lines = input.split("\n")
    steps = lines.first.chars

    nodes = lines[2..].to_h do |line|
      [
        line[0..2],
        [
          line[7..9],
          line[12..14]
        ]
      ]
    end

    [steps, nodes]
  end

  def part1(input)
    steps, nodes = parse(input)

    current = 'AAA'
    index = 0
    count = 0

    loop do
      count += 1
      step = steps[index]

      current = nodes[current][step == 'L' ? 0 : 1]

      break if current == 'ZZZ'

      index += 1
      index = 0 if index == steps.length
    end

    count
  end

  def part2(input)
    steps, nodes = parse(input)

    positions = nodes.keys.select { |key| key.end_with?('A') }

    distances = positions.map do |pos|
      index = 0
      count = 0

      loop do
        count += 1
        step = steps[index]

        pos = nodes[pos][step == 'L' ? 0 : 1]

        break if pos.end_with?('Z')

        index += 1
        index = 0 if index == steps.length
      end

      count
    end

    distances.reduce(1, :lcm)
  end

end
