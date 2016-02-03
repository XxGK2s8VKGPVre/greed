require 'test/unit'
require_relative '../src/turn'

class TurnTest < Test::Unit::TestCase
  def test_save_five
    turn = Turn.new(0, [2,2,3,4,5])
    turn.save
    assert_equal 50, turn.score
    assert_equal [2,2,3,4], turn.dice
  end
  
  def test_save_one_five
    turn = Turn.new(0, [2,2,3,5,5])
    turn.save
    assert_equal 50, turn.score
    assert_equal [2,2,3,5], turn.dice
  end

  def test_save_one
    turn = Turn.new(0, [2,2,3,4,1])
    turn.save
    assert_equal 100, turn.score
    assert_equal [2,2,3,4], turn.dice
  end

  def test_save_one_one
    turn = Turn.new(0, [2,2,3,1,1])
    turn.save
    assert_equal 100, turn.score
    assert_equal [2,2,3,1], turn.dice
  end
  
  def test_save_when_four_of_a_number
    turn = Turn.new(0, [2,2,2,2,3])
    turn.save
    assert_equal 200, turn.score
    assert_equal [2,3], turn.dice
  end
  
  def test_save_when_nothing_to_save
    turn = Turn.new(0, [2,2,3,3,4])
    turn.save
    assert_equal 0, turn.score
    assert_equal [], turn.dice
  end

  def test_best_thing_to_save
    dice = [2,2]
    assert_equal [], best_thing_to_save(dice)
    dice = [5,2,2]
    assert_equal [5], best_thing_to_save(dice)
    dice = [1,2,2]
    assert_equal [1], best_thing_to_save(dice)
    dice = [5,1,2]
    assert_equal [1], best_thing_to_save(dice)
    dice = [3,3,3,4]
    assert_equal [3,3,3], best_thing_to_save(dice)
    dice = [2,3,1,1,1]
    assert_equal [1,1,1], best_thing_to_save(dice)
  end


  def test_save_one_if_one_and_five_present
    turn = Turn.new(0, [1,5])
    turn.save
    assert_equal 100, turn.score
    assert_equal [5], turn.dice
  end
  
  def test_bust
    turn = Turn.new(0, [4,6,2,2,4])
    assert turn.bust?
    turn.dice = [5,2,2,4,6]
    assert !turn.bust?
    turn.dice = [1,1,1,4,6]
    assert !turn.bust?
  end
  
  def test_score_over_threshold?
    test_threshold = 250
    turn = Turn.new(0, [1,1,1,2,4])
    assert turn.score_over_threshold?(test_threshold)
    turn = Turn.new(50, [2,2,2,4,3])
    assert turn.score_over_threshold?(test_threshold)
    turn = Turn.new(0, [2,2,2,4,3])
    assert !turn.score_over_threshold?(test_threshold)
  end
  
  def test_and_rolling?
    turn = Turn.new(0, [1,1,2,2,2])
    assert turn.and_rolling?
    turn = Turn.new(0, [6,6,6,1,5])
    assert turn.and_rolling?
    turn = Turn.new(0, [1,1,1,1,1])
    assert turn.and_rolling?
    turn = Turn.new(0, [5,5,5,5,5])
    assert turn.and_rolling?
    turn = Turn.new(0, [5,1,1,4,5])
    assert !turn.and_rolling?
    turn = Turn.new(0, [4,4,6,2,3])
    assert !turn.and_rolling?
    turn = Turn.new(50, [1,1,1,5])
    assert turn.and_rolling?
    turn = Turn.new(1050, [1])
    assert turn.and_rolling?
  end
end