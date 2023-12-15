require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay15 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '15.txt')).rstrip
    @day = Day15.new
  end

  def test_part1
    assert_equal @day.part1(@data), 1320
  end

  def test_part2
    assert_equal @day.part2(@data), 145
  end
end
