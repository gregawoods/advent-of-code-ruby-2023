class Day07

  # LABELS = ['High Card', 'Pair', 'Two Pair', 'Three of a Kind', 'Full House', 'Four of a Kind', 'Five of a Kind']
  CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'].freeze

  HandP1 = Struct.new(:cards, :bid) do
    def hand_value
      counts = cards.chars.group_by(&:to_s).values.map(&:length)

      if counts == [5]
        6
      elsif counts.include?(4)
        5
      elsif counts.include?(3) && counts.include?(2)
        4
      elsif counts.include?(3)
        3
      elsif counts.select { |c| c == 2 }.length == 2
        2
      elsif counts.include?(2)
        1
      else
        0
      end
    end

    def card_value
      cards.chars.map { |c| CARD_VALUES.index(c).to_s.rjust(2, '0') }.join
    end

    def value
      "#{hand_value}.#{card_value}".to_f
    end
  end

  def part1(input)
    hands = input.split("\n").map do |line|
      args = line.split.map(&:strip)
      HandP1.new(args.first, args.last.to_i)
    end

    hands.sort_by(&:value).each_with_index.map do |h, index|
      h.bid * (index + 1)
    end.sum
  end

  CARD_VALUES_2 = ['J', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'Q', 'K', 'A'].freeze

  HandP2 = Struct.new(:cards, :bid) do
    def hand_value
      jokers = cards.scan('J').length
      counts = cards.delete('J').chars.group_by(&:to_s).values.map(&:length)

      if counts.length == 1 || jokers == 5 # 5 of a kind
        6
      elsif counts.max == 4 || counts.max + jokers == 4 || jokers == 4 # 4 of a kind
        5
      elsif (counts.include?(3) && counts.include?(2)) || # full house
            jokers == 3 ||
            (jokers == 2 && counts.length == 2) ||
            (jokers == 1 && counts.length == 2)
        4
      elsif counts.max == 3 || jokers == 3 || counts.max + jokers == 3 # 3 of a kind
        3
      elsif counts.select { |c| c == 2 }.length == 2 || jokers >= 2 # 2 pair
        2
      elsif counts.include?(2) || jokers.positive? # pair
        1
      else
        0
      end
    end

    def card_value
      cards.chars.map { |c| CARD_VALUES.index(c).to_s.rjust(2, '0') }.join
    end

    def value
      "#{hand_value}.#{card_value}".to_f
    end
  end

  def part2(input)
    hands = input.split("\n").map do |line|
      args = line.split.map(&:strip)
      HandP2.new(args.first, args.last.to_i)
    end

    hands.sort_by(&:value).each_with_index.map do |h, index|
      h.bid * (index + 1)
    end.sum
  end

end
