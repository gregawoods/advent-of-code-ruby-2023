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
    # Obviously forking is not the "correct" solution to this puzzle, but sometimes
    # CPUs are faster than brains, and a star is a star. Maybe refactor later. 🙃

    return -1 if ENV['SKIP_LONG_RUNNING_SOLUTIONS']

    seeds, mappings = parse(input)

    reads = []
    writes = []

    seeds.each_slice(2) do |index, stride|
      read, write = IO.pipe
      reads << read
      writes << write

      fork do
        # pid = Process.pid
        # puts "BEGIN #{pid}: #{index} => #{stride}"
        result = Float::INFINITY

        stride.times do |n|
          # puts "#{pid}: #{n}/#{stride} (#{(n.to_f / stride * 100).round(1)}%)" if (n % 500_000).zero?

          seed = index + n
          mappings.each do |mapping|
            seed = mapping.value(seed)
          end
          result = [seed, result].min
        end

        Marshal.dump(result, write)
        write.close

        # puts "END #{pid}: #{index} => #{stride} (Result: #{result})"
      end
    end
    Process.waitall

    writes.each(&:close)
    results = reads.map { |p| Marshal.load(p.read) } # rubocop:disable Security/MarshalLoad

    results.min
  end

end
