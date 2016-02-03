require_relative 'roll'
require_relative 'set'
require_relative 'score'

class Turn
  attr_accessor :score, :dice
  
  def initialize(score, dice)
    @score = score
    @dice = dice
  end
  
  def save
    score_on_roll = score_roll(self.dice)
    dice_to_save = best_thing_to_save(self.dice)
    self.score += score_roll(dice_to_save)
    if dice_to_save.size != 0
      dice_to_save.size.times { self.dice.delete_at(self.dice.find_index(dice_to_save[0])) }
    else
      self.dice = []
    end
  end
  
  def start_new_turn
    self.score = 0
    self.dice = roll_dice(5)
  end
  
  def play_turn(threshold)
    if self.bust?
      return 0
    elsif and_rolling?
      self.score += score_roll(self.dice)
      self.dice = roll_dice(5)
      self.play_turn(threshold)
    elsif score_over_threshold?(threshold)
      self.score += score_roll(self.dice)
      return self.score
    else
      self.save
      self.dice = roll_dice(self.dice.size)
      self.play_turn(threshold)
    end
  end
  
  def bust?
    best_thing_to_save(self.dice).size == 0
  end
  
  def and_rolling?
    scoring_dice = 0
    scoring_dice += self.dice.count(1)
    scoring_dice += self.dice.count(5)
    set_number = find_set_number(self.dice)
    if set_number == 2 || set_number == 3 || set_number == 4 || set_number == 6
      scoring_dice += 3
    end
    return scoring_dice == self.dice.size
  end
  
  def score_over_threshold?(threshold)
    self.score + score_roll(self.dice) >= threshold
  end
end

def best_thing_to_save(dice)
  set_number = find_set_number(dice)
  if set_number != 0
    return [set_number, set_number, set_number] 
  elsif dice.include?(1)
    return [1]
  elsif dice.include?(5)
    return [5]
  else
    return []
  end
end