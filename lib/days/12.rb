class Day12

  def part1(input)
    count = 0

    input.split("\n").each do |row|
      a, b = row.split

      data = a.chars

      legend = b.split(',').map(&:to_i)

      combos = build_combinations(data, legend)

      count += combos.count do |c|
        convert_data(c) == legend
      end
    end

    count
  end

  def build_combinations(data, legend, current = [[]])
    results = []

    current.each do |combo|
      next_value = data[combo.length]

      if next_value == '?'
        results << combo.map(&:clone).append('.')
        results << combo.map(&:clone).append('#')
      else
        results << combo.map(&:clone).append(next_value)
      end
    end

    if results.first.length == data.length
      results
    else
      build_combinations(data, legend, results)
    end
  end

  def convert_data(data)
    data.join.split(/\.+/).reject(&:empty?).map(&:length)
  end

  def part2(_input)
    'TODO'
  end

end
