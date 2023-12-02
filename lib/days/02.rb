class Day02

  Game = Struct.new(:id, :red, :green, :blue) do
    def possible?(red:, green:, blue:)
      self.red <= red && self.green <= green && self.blue <= blue
    end

    def power
      red * green * blue
    end
  end

  def build_games_from_input(input)
    input.split("\n").each_with_index.map do |line, index|
      game = Game.new(index + 1, 0, 0, 0)

      line.split(': ').last.split('; ').each do |set|
        set.split(', ').each do |hand|
          number, color = hand.split
          case color
          when 'red'
            game.red = [game.red, number.to_i].max
          when 'green'
            game.green = [game.green, number.to_i].max
          when 'blue'
            game.blue = [game.blue, number.to_i].max
          end
        end
      end

      game
    end
  end

  def part1(input)
    build_games_from_input(input).select { |g| g.possible?(red: 12, green: 13, blue: 14) }.sum(&:id)
  end

  def part2(input)
    build_games_from_input(input).sum(&:power)
  end

end
