require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay17 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '17.txt')).rstrip
    @data_b = File.read(File.join(APP_ROOT, 'examples', '17_b.txt')).rstrip
    @day = Day17.new
  end

  def test_part1
    assert_equal @day.part1(@data), 102
  end

  def test_part2
    assert_equal @day.part2(@data_b), 71
    assert_equal @day.part2(@data), 94
  end
end
