require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay05 < Minitest::Test
  def setup
    @data = File.read(File.join(APP_ROOT, 'examples', '05.txt')).rstrip
    @day = Day05.new
  end

  def test_part1
    assert_equal @day.part1(@data), 35
  end

  def test_part2
    assert_equal @day.part2(@data), 46
  end
end
