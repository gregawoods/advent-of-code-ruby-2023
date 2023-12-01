class Day01

  def part1(input)
    input.split("\n").map do |line|
      nums = line.chars.grep(/\d/)
      (nums.first + nums.last).to_i
    end.sum
  end

  DIGITS = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'].freeze

  def part2(input)
    regex = Regexp.new("(?=(#{DIGITS.join('|')}|\\d))")

    input.split("\n").map do |line|
      nums = line.scan(regex).flatten.map do |m|
        DIGITS.include?(m) ? DIGITS.index(m) : m
      end

      "#{nums.first}#{nums.last}".to_i
    end.sum
  end

end
