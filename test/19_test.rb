require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay19 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '19.txt')).rstrip
    @day = Day19.new
  end

  def test_part1
    assert_equal @day.part1(@data), 19114
  end

  def test_part2
    assert_equal @day.part2(@data), ''
  end
end
