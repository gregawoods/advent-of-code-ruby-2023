class Day14

  def part1(input)
    lines = input.split("\n")

    columns = []

    lines.length.times do |n|
      lines[n].chars.each_with_index do |char, i|
        columns[i] ||= []
        columns[i] << char
      end
    end

    columns = columns.map do |c|
      shift_column(c)
    end

    value = 0

    columns.each do |col|
      col.each_with_index do |obj, index|
        if obj == 'O'
          value += (col.length - index)
        end
      end
    end

    value
  end

  def shift_column(column)
    column.length.times do |n|
      next if n.zero?

      n.times do |i|
        position = n - i

        char = column[position]
        prev_char = column[position - 1]

        if char == 'O' && prev_char == '.'
          column[position] = '.'
          column[position - 1] = 'O'
        else
          break
        end
      end
    end

    column
  end

  def rotate_clockwise(columns)
    new_columns = []

  end

  def part2(input)
    'TODO'
  end

end
