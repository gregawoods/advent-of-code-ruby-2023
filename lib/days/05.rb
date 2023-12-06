class Day05

  RangeMap = Struct.new(:key_index, :val_index, :stride) do
    def include?(val)
      (val_index..(val_index + stride)).include?(val)
    end

    def value(val)
      key_index + (val - val_index)
    end
  end

  Mapping = Struct.new(:from, :to, :range_maps) do
    def value(val)
      range_maps.each do |rm|
        return rm.value(val) if rm.include?(val)
      end
      val
    end
  end

  def parse(input)
    chunks = input.split("\n\n")
    seeds = chunks.shift.sub('seeds:', '').split.map(&:to_i)
    mappings = []

    chunks.each do |chunk|
      lines = chunk.split("\n")
      labels = lines.shift.sub(' map:', '').split('-to-')
      mapping = Mapping.new(labels.first, labels.last, [])

      lines.each do |line|
        mapping.range_maps << RangeMap.new(*line.split.map(&:to_i))
      end

      mappings << mapping
    end

    [seeds, mappings]
  end

  def part1(input)
    seeds, mappings = parse(input)

    seeds.map do |seed|
      mappings.each do |mapping|
        seed = mapping.value(seed)
      end

      seed
    end.min
  end

  def part2(input)
    seeds, mappings = parse(input)
    results = {}

    seeds.each_slice(2) do |index, stride|
      stride.times do |n|
        key = index + n
        next if results.key?(key)

        seed = index + n
        mappings.each do |mapping|
          seed = mapping.value(seed)
        end

        results[key] = seed
      end
    end

    # Passes test but is too slow for real input
    # results.values.min
  end

end
