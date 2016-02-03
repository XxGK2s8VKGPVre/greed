require_relative 'turn'
require_relative 'score'

def play_game(winning_score, threshold)
  total_score = 0
  counter = 0
  turn = Turn.new(0,[])
  until total_score > winning_score do
    turn.start_new_turn
    total_score += turn.play_turn(threshold)
    counter += 1
  end
  return counter
end