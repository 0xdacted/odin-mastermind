# computer selects 4 colors out of 6 options and places them in selection order. human has 12 guesses to guess the secret code. 
# human receives feedback upon each guess
require 'pry-byebug'

class Computer
  @@peg_options = ['red', 'blue', 'purple', 'green', 'pink', 'blank']
  @@selected_pegs = []

  def select_pegs
    for i in 0..3
    color = @@peg_options.sample
    @@selected_pegs.push(color)
    binding.pry
    end
  end
end

class Human

end

computer_player = Computer.new
computer_player.select_pegs