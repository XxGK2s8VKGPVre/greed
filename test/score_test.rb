require 'test/unit'
require_relative '../src/score'

class ScoreTest < Test::Unit::TestCase
  def test_score_set
    mock_array_with_set_of_ones = [1,2,3,1,1]
    mock_array_with_set_of_four_ones = [1,1,3,1,1]
    mock_array_with_set_of_fives = [5,2,3,5,5]
    mock_array_without_set = [1,2,3,4,5]
    assert_equal 500, score_set(mock_array_with_set_of_fives)
    assert_equal 1000, score_set(mock_array_with_set_of_ones)
    assert_equal 100, score_specific_rolls(1, 100, mock_array_with_set_of_four_ones)
    assert_equal 0, score_set(mock_array_without_set)
  end
  
  def test_score_specific_rolls
    mock_array_with_one_one = [1,2,3,4,2]
    mock_array_with_two_ones = [1,2,1,4,2]
    assert_equal 100, score_specific_rolls(1, 100, mock_array_with_one_one)
    assert_equal 200, score_specific_rolls(1, 100, mock_array_with_two_ones)
    
    mock_array_with_one_five = [2,5,3,4,2]
    mock_array_with_two_fives = [5,2,5,4,2]
    assert_equal 50, score_specific_rolls(5, 50, mock_array_with_one_five)
    assert_equal 100, score_specific_rolls(5, 50, mock_array_with_two_fives)
  end
  
  def test_score
    mock_array_with_four_ones = [1,1,1,1,3]
    mock_array_with_five_ones = [1,1,1,1,1]
    assert_equal 1100, score_roll(mock_array_with_four_ones)
    assert_equal 1200, score_roll(mock_array_with_five_ones)
  end
  
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score_roll([])
  end
  
  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score_roll([5])
  end
  
  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score_roll([1])
  end
  
  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score_roll([1,5,5,1])
  end
  
  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score_roll([2,3,4,6])
  end
  
  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score_roll([1,1,1])
  end
  
  def test_score_of_other_triples_is_100x
    assert_equal 200, score_roll([2,2,2])
    assert_equal 300, score_roll([3,3,3])
    assert_equal 400, score_roll([4,4,4])
    assert_equal 500, score_roll([5,5,5])
    assert_equal 600, score_roll([6,6,6])
  end
  
  def test_score_of_mixed_is_sum
    assert_equal 250, score_roll([2,5,2,2,3])
    assert_equal 600, score_roll([5,5,5,5,5])
  end

end
