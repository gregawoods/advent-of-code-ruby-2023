require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay14 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '14.txt')).rstrip
    @day = Day14.new
  end

  def test_part1
    assert_equal @day.part1(@data), 136
  end

  def test_part2
    assert_equal @day.part2(@data), 64
  end
end
