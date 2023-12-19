class Day19

  Rule = Data.define(:destination, :operation, :category, :value) do
    def matches?(part)
      return true if operation.nil?

      part.send(category).send(operation, value)
    end
  end

  Part = Struct.new(:x, :m, :a, :s) do
    def value
      x + m + a + s
    end
  end

  def parse(input)
    rule_regex = /(?<cat>[a-z])(?<op>[<>])(?<value>\d+):(?<dest>[a-zA-Z]+)/

    flows_str, parts_str = input.split("\n\n")

    flows = flows_str.split("\n").to_h do |line|
      name, rest = line.split('{')

      rules = rest[0...-1].split(',').map do |str|
        if (match = str.match(rule_regex))
          Rule.new(
            match['dest'],
            match['op'],
            match['cat'].to_sym,
            match['value'].to_i
          )
        else
          Rule.new(str, nil, nil, nil)
        end
      end

      [name, rules]
    end

    part_regex = /x=(?<x>\d+),m=(?<m>\d+),a=(?<a>\d+),s=(?<s>\d+)/

    parts = parts_str.split("\n").map do |line|
      if (match = line.match(part_regex))
        Part.new(match['x'].to_i, match['m'].to_i, match['a'].to_i, match['s'].to_i)
      else
        raise "Unexpected part format #{line}!"
      end
    end

    [flows, parts]
  end

  def part1(input)
    flows, parts = parse(input)

    accepted = []
    rejected = []

    parts.each do |part|
      current = 'in'

      loop do
        if current == 'R'
          rejected << part
          break
        elsif current == 'A'
          accepted << part
          break
        end

        workflow = flows[current]

        workflow.each do |rule|
          if rule.matches?(part)
            current = rule.destination
            break
          end
        end
      end
    end

    accepted.sum(&:value)
  end

  def part2(input)
    'TODO'
  end

end
