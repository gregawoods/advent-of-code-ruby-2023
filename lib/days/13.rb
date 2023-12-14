class Day13

  def part1(input)
    input.split("\n\n").sum do |chunk|
      find_reflections(chunk).first
    end
  end

  def find_mirror_columns(chunk)
    rows = chunk.split("\n")

    mirror_columns = []

    (1..(rows.first.length - 1)).each do |n|
      is_mirror = true

      (0..(rows.length - 1)).each do |i|
        row = rows[i]

        left = row[0, n]
        right = row[n, left.length]

        if left.length > right.length
          left = left[(left.length - right.length)..]
        end

        if left != right.reverse
          is_mirror = false
          break
        end
      end

      if is_mirror
        mirror_columns << n
      end
    end

    mirror_columns
  end

  def find_mirror_rows(chunk)
    rows = chunk.split("\n")

    mirror_rows = []

    (1..(rows.length - 1)).each do |n|
      is_mirror = true

      (0..(rows[n].length - 1)).each do |i|
        column = rows.map { |r| r[i] }.join

        top = column[0, n]
        bottom = column[n, top.length]

        if top.length > bottom.length
          top = top[(top.length - bottom.length)..]
        end

        if top != bottom.reverse
          is_mirror = false
          break
        end
      end

      if is_mirror
        mirror_rows << (n * 100)
      end
    end

    mirror_rows
  end

  def find_reflections(chunk)
    find_mirror_columns(chunk) + find_mirror_rows(chunk)
  end

  def part2(input)
    input.split("\n\n").sum do |chunk|
      original_reflection = find_reflections(chunk).first

      chunk.length.times do |i|
        next if chunk[i] == "\n"

        new_chunk = chunk.dup
        new_chunk[i] = new_chunk[i] == '.' ? '#' : '.'

        reflection = find_reflections(new_chunk).find { |r| r != original_reflection }

        break reflection if reflection
      end
    end
  end

end
