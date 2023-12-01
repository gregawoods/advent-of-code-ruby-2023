require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay01 < Minitest::Test
  def setup
    @data_a = File.read(File.join(APP_ROOT, 'examples', '01_a.txt')).rstrip
    @data_b = File.read(File.join(APP_ROOT, 'examples', '01_b.txt')).rstrip
    @day = Day01.new
  end

  def test_part1
    assert_equal @day.part1(@data_a), 142
  end

  def test_part2
    assert_equal @day.part2(@data_b), 281
  end
end
