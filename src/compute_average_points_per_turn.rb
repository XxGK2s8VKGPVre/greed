require_relative 'play_game'

threshold = 50
while threshold <= 500 do
  sum = 0
  10000.times do
    sum += play_game(5000,threshold)
  end
  p "With the threshold of #{threshold} the average number of turns over 10000 games was #{sum / 10000.0}"
  threshold += 50
end