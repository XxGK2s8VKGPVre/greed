def find_set_number(dice)
  set_number = 0
  for i in 1..6
    set_number = i if dice.find_all { |roll| roll == i }.size >= 3
  end
  set_number
end