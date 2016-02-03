require_relative 'set'

def score_roll(dice)
  score = 0
  score += score_set(dice)
  score += score_specific_rolls(5, 50, dice)
  score += score_specific_rolls(1, 100, dice)
  return score
end

def score_set(dice)
  set_number = find_set_number(dice)
  if set_number == 1
    return 1000
  else
    return set_number * 100
  end
end

def score_specific_rolls(specific_roll, points_awarded, dice)
  specific_rolls = dice.find_all { |roll| roll == specific_roll }
  if specific_rolls.size >= 3
    return points_awarded * (specific_rolls.size - 3)
  else
    return points_awarded * specific_rolls.size
  end
end