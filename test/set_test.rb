require 'test/unit'
require_relative '../src/set'

class SetTest < Test::Unit::TestCase
  def test_find_set_number
    assert_equal 4, find_set_number([4,4,4,2,1])
    assert_equal 1, find_set_number([1,4,1,2,1])
    assert_equal 0, find_set_number([4,4,3,2,1])
  end
end