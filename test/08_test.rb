require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay08 < Minitest::Test
  def setup
    @day = Day08.new
  end

  def test_part1
    data = File.read(File.join(APP_ROOT, 'examples', '08.txt')).rstrip
    assert_equal @day.part1(data), 6
  end

  def test_part2
    data = File.read(File.join(APP_ROOT, 'examples', '08_2.txt')).rstrip
    assert_equal @day.part2(data), 6
  end
end
