require 'minitest/unit'
require 'minitest/autorun'

require './distance.rb'

class DistanceTest < MiniTest::Unit::TestCase

  def test_edit_distance_equal_length
    assert_equal 1, edit_distance('aax', 'aaa')
    assert_equal 2, edit_distance('aoeui', 'aoxxi')
    assert_equal 3, edit_distance('abc', 'def')
  end

  def test_edit_distance_longer_target
    assert_equal 1, edit_distance('xz', 'xyz')
    assert_equal 2, edit_distance('ab', 'abxy')
    assert_equal 2, edit_distance('ae', 'axey')
    assert_equal 5, edit_distance('abc', 'defgh')
    assert_equal 2, edit_distance('ace', 'abcde')
  end

  def test_edit_distance_longer_source
    assert_equal 2, edit_distance('abcd', 'axd')
    assert_equal 2, edit_distance('abc', 'c')
    assert_equal 4, edit_distance('abcde', 'c')
    assert_equal 3, edit_distance('abcde', 'abx')
    assert_equal 3, edit_distance('abc', 'x')
  end

  def test_set_difference
    assert_equal set_difference('abcde', 'ab'), Set.new('cde'.chars)
    assert_equal set_difference('abc', 'bcd'), Set.new(['a'])
    assert_equal set_difference('abc', 'def'), Set.new('abc'.chars)
    assert_equal set_difference('cabbc', 'bd'), Set.new('ac'.chars)
  end

  def test_char_indicies
    assert_equal char_indicies('abc abc abc', 'a'), [0,4,8]
    assert_equal char_indicies('aaa bbb', 'a'), [0,1,2]
    assert_equal char_indicies('aaa bbb', 'b'), [4,5,6]
  end

end
