require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay12 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '12.txt')).rstrip
    @day = Day12.new
  end

  def test_part1
    assert_equal @day.part1(@data), 21
  end

  def test_part2
    assert_equal @day.part2(@data), 'TODO'
  end
end
