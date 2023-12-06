class Day06

  def part1(input)
    lines = input.split("\n")
    times = lines.first.split[1..].map(&:to_i)
    distances = lines.last.split[1..].map(&:to_i)

    result = 1

    times.each_with_index do |time, index|
      result *= calculate(time, distances[index])
    end

    result
  end

  def part2(input)
    lines = input.split("\n")
    time = lines.first[11..].gsub(' ', '').to_i
    distance = lines.last[11..].gsub(' ', '').to_i

    calculate(time, distance)
  end

  def calculate(time, goal)
    wins = 0
    speed = 0

    (1..time).each do |hold_duration|
      speed += 1
      wins += 1 if speed * (time - hold_duration) > goal
    end

    wins
  end

end
