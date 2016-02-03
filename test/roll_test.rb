require 'test/unit'
require_relative '../src/roll'

class RollTest < Test::Unit::TestCase
  def test_roll
    sample_roll = roll_dice(5)
    assert_equal 5, sample_roll.size
    assert_match /[1-6]/, sample_roll[0].to_s
  end

  def test_keep_rolling_with_five
    dice = [2,2,3,3,5]
    assert roll_again?(dice)
    dice = [2,5]
    assert roll_again?(dice)
  end

  def test_keep_rolling_with_one
    dice = [2,2,3,3,1]
    assert roll_again?(dice)
    dice = [1]
    assert roll_again?(dice)
  end

  def test_keep_rolling_with_set
    dice = [2,2,2,3,4]
    assert roll_again?(dice)    
  end

  def test_keep_rolling_with_set_and_one
    dice = [2,2,2,3,1]
    assert roll_again?(dice)
  end

  def test_cannot_keep_rolling
    dice = [2,2,3,3,4]
    assert !roll_again?(dice)
    dice = [4]
    assert !roll_again?(dice)    
  end
end