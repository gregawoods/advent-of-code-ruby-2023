require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay02 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '02.txt')).rstrip
    @day = Day02.new
  end

  def test_part1
    assert_equal @day.part1(@data), 8
  end

  def test_part2
    assert_equal @day.part2(@data), 2286
  end
end
