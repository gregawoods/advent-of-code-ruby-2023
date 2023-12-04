class Day04

  Card = Struct.new(:winning_numbers, :my_numbers, :instances) do
    def matches
      (winning_numbers & my_numbers).length
    end
  end

  def parse(input)
    input.split("\n").map do |line|
      line.gsub!(/.+:\s+/, '')
      a, b = line.split('|')

      Card.new(
        winning_numbers: a.split.map(&:strip),
        my_numbers: b.split.map(&:strip),
        instances: 1
      )
    end
  end

  def part1(input)
    parse(input).map do |card|
      value = 0

      if card.matches.positive?
        value = 1
        (card.matches - 1).times { value *= 2 }
      end

      value
    end.sum
  end

  def part2(input)
    cards = parse(input)

    cards.each_with_index do |current_card, index|
      current_card.matches.times do |n|
        next_card = cards[index + n + 1]
        next_card.instances += current_card.instances unless next_card.nil?
      end
    end

    cards.sum(&:instances)
  end

end
