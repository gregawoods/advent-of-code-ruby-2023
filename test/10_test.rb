require 'minitest/autorun'
require 'minitest/pride'
require_relative '../app'

class TestDay10 < Minitest::Test
  def setup
    @day = Day10.new
  end

  def test_part1
    data_a = File.read(File.join(APP_ROOT, 'examples', '10_a.txt')).rstrip
    assert_equal @day.part1(data_a), 4

    data_b = File.read(File.join(APP_ROOT, 'examples', '10_b.txt')).rstrip
    assert_equal @day.part1(data_b), 8
  end

  def test_part2
    data_c = File.read(File.join(APP_ROOT, 'examples', '10_c.txt')).rstrip
    assert_equal @day.part2(data_c), 4

    data_d = File.read(File.join(APP_ROOT, 'examples', '10_d.txt')).rstrip
    assert_equal @day.part2(data_d), 4

    data_e = File.read(File.join(APP_ROOT, 'examples', '10_e.txt')).rstrip
    assert_equal @day.part2(data_e), 10
  end
end
