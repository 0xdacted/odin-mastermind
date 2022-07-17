# computer selects 4 colors out of 6 options and places them in selection order. human has 12 guesses to guess the secret code. 
# human receives feedback upon each guess
require 'pry-byebug'

class Player
  @@peg_options = ['red', 'blue', 'purple', 'green', 'pink', 'blank']
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
      @@guessed_pegs[i] = gets.chomp.downcase
    end
  end
end

computer_player = Computer.new
human_player = Human.new
computer_player.select_pegs
human_player.guess_pegs