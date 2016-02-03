require_relative 'score'

def roll_dice(times_to_roll)
  dice_set = []
  times_to_roll.times do
    dice_set << 1 + rand(6)
  end
  return dice_set
end

def roll_again?(dice)
  score_roll(dice) > 0
end