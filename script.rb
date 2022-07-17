# computer selects 4 colors out of 6 options and places them in selection order. human has 12 guesses to guess the secret code.
# human receives feedback detailing whether the color was correct, the color and order were correct, or neither upon each guess.
require 'pry-byebug'
class Player
  @@peg_options = %w[red blue purple green pink blank]
  @@selected_pegs = []
  @@guessed_pegs = []
end

class Computer < Player
  def select_pegs
    for i in 0..3
      color = @@peg_options.sample
      @@selected_pegs.push(color)
    end
  end
end

class Human < Player
  def guess_pegs
    for i in 0..3
      p "Given #{@@peg_options}, please input your ##{i} guess"
      user_guess = gets.chomp.downcase
      if @@peg_options.include?(user_guess)
        @@guessed_pegs[i] = user_guess
      else
        guess_pegs
      end

      if @@selected_pegs[i] == @@guessed_pegs[i]
        p "Your guess of #{@@guessed_pegs[i]} at position #{i} is correct!"
      elsif @@selected_pegs.include?(@@guessed_pegs[i])
        p "Your guess of #{@@guessed_pegs[i]} is included in the computer's selection, but the position #{i} is incorrect."
      else
        p "your guess of #{@@guessed_pegs[i]} is not included in the computer's selection."
      end
  end
  end

  def winner?
    if @@guessed_pegs == @@selected_pegs
      'Congratulations, you have guessed the peg order correctly and beat the computer!'
    end
  end
end

computer_player = Computer.new
human_player = Human.new
computer_player.select_pegs

i = 0
while i < 12
  human_player.guess_pegs
  i += 1
  if human_player.winner?
    p human_player.winner?
    break
  else
    p "Your guessed order is incorrect! you have #{12 - i} tries remaining"
  end
end
