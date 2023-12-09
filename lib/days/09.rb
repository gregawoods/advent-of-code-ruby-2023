class Day09

  def parse(input)
    input.split("\n").map do |line|
      table = [line.split.map(&:to_i)]

      loop do
        table << (0..(table.last.length - 2)).map do |n|
          table.last[n + 1] - table.last[n]
        end

        break if table.last.all?(&:zero?)
      end

      table.reverse!
    end
  end

  def part1(input)
    parse(input).map do |table|
      (0..(table.length - 2)).each do |n|
        table[n + 1] << (table[n].last + table[n + 1].last)
      end

      table.last.last
    end.sum
  end

  def part2(input)
    parse(input).map do |table|
      (0..(table.length - 2)).each do |n|
        new_value = -1 * (table[n].first - table[n + 1].first)

        table[n + 1].unshift new_value
      end

      table.last.first
    end.sum
  end

end
