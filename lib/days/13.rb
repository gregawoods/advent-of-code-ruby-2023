class Day13

  def part1(input)
    cols = 0
    rows = 0

    input.split("\n\n").each do |chunk|
      mirror_column = find_mirror_column(chunk)

      if mirror_column
        cols += mirror_column + 1
      else
        mirror_row = find_mirror_row(chunk)
        rows += mirror_row + 1
      end
    end

    (rows * 100) + cols
  end

  def find_mirror_column(chunk)
    rows = chunk.split("\n")

    mirror_column = nil

    (0..(rows.first.length - 2)).each do |n|
      is_mirror = true

      (0..(rows.length - 1)).each do |i|
        row = rows[i]

        left = row[0..n]
        right = row[(n + 1), left.length]

        if left.length > right.length
          left = left[(left.length - right.length)..]
        end

        if left != right.reverse
          is_mirror = false
          break
        end
      end

      if is_mirror
        mirror_column = n
        break
      end
    end

    mirror_column
  end

  def find_mirror_row(chunk)
    rows = chunk.split("\n")

    mirror_row = nil

    (0..(rows.length - 2)).each do |n|
      is_mirror = true

      (0..(rows[n].length - 1)).each do |i|
        column = rows.map { |r| r[i] }.join

        top = column[0..n]
        bottom = column[(n + 1), top.length]

        if top.length > bottom.length
          top = top[(top.length - bottom.length)..]
        end

        if top != bottom.reverse
          is_mirror = false
          break
        end
      end

      if is_mirror
        mirror_row = n
        break
      end
    end

    mirror_row
  end

  def part2(input)
    'TODO'
  end

end
