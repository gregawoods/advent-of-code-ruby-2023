class Day15

  def part1(input)
    input.split(',').map { |s| compute_hash(s) }.sum
  end

  def compute_hash(str)
    str.chars.reduce(0) do |value, char|
      code = char.ord
      value += code
      value *= 17
      value %= 256
      value
    end
  end

  Lens = Struct.new(:label, :focal_length)

  def part2(input)
    boxes = {}

    input.split(',').each do |step|
      if step.include?('=')
        label, value = step.split('=')
        box_num = compute_hash(label)

        boxes[box_num] ||= []
        new_lens = Lens.new(label, value.to_i)

        index = boxes[box_num].index { |b| b.label == label }
        if index
          boxes[box_num][index] = new_lens
        else
          boxes[box_num] << new_lens
        end
      else
        label = step[0...-1]
        box_num = compute_hash(label)

        if boxes[box_num]
          index = boxes[box_num].index { |b| b.label == label }
          boxes[box_num].delete_at(index) if index
        end
      end
    end

    boxes.sum do |box_num, box|
      box.each_with_index.sum do |lens, index|
        (box_num + 1) * (index + 1) * lens.focal_length
      end
    end
  end

end
