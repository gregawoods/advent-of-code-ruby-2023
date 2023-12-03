require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay03 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '03.txt')).rstrip
    @day = Day03.new
  end

  def test_part1
    assert_equal @day.part1(@data), 4361
  end

  def test_part2
    assert_equal @day.part2(@data), 467835
  end
end
