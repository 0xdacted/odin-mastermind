class Player
  @@peg_options = %w[red blue purple green pink blank]
  @@selected_pegs = []
  @@guessed_pegs = []
  @@player_role = ''
  @@computer_role = ''

  def winner?
    if @@guessed_pegs == @@selected_pegs
      "Congratulations, #{self} has guessed the peg order correctly and beat their opponent!"
    end
  end

  def guess_loop
    i = 0
    while i < 12
      guess_pegs
      i += 1
      if winner?
        p winner?
        break
      else
        p "#{self}'s guessed order is incorrect! #{self} has #{12 - i} tries remaining"
      end
    end
  end
end

class Computer < Player
  @@correct_guesses = []

  def select_role
    if @@selected_pegs.length == 0
      for i in 0..3
        color = @@peg_options.sample
        @@selected_pegs.push(color)
      end
    else
      @@computer_role = 'breaker'
    end
  end

  def guess_pegs
    if @@correct_guesses.compact.length == 4
      @@guessed_pegs = @@correct_guesses
      winner?
    else
      for i in 0..3
        computer_guess = @@peg_options.sample
        @@guessed_pegs[i] = computer_guess

        if @@selected_pegs[i] == @@guessed_pegs[i]
          p "#{self}'s guess of #{@@guessed_pegs[i]} at position #{i} is correct!"
          @@correct_guesses[i] = @@guessed_pegs[i]
        elsif @@selected_pegs.include?(@@guessed_pegs[i])
          p "#{self}'s guess of #{@@guessed_pegs[i]} is included in the the player's selection, but the position #{i} is incorrect."
        else
          p "#{self}'s guess of #{@@guessed_pegs[i]} is not included in the player's selection."
        end
      end
    end
  end

  def play_round
    guess_loop if @@computer_role == 'breaker'
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
        p "#{self}'s guess of #{@@guessed_pegs[i]} at position #{i} is correct!"
      elsif @@selected_pegs.include?(@@guessed_pegs[i])
        p "#{self}'s guess of #{@@guessed_pegs[i]} is included in the computer's selection, but the position #{i} is incorrect."
      else
        p "#{self}'s guess of #{@@guessed_pegs[i]} is not included in the computer's selection."
      end
    end
  end

  def select_role
    p "If you would like to be the code-maker, type 'y' and select enter, otherwise, enter 'n' to be the code-breaker"
    user_selection = gets.chomp.downcase
    if user_selection == 'y'
      select_pegs
    elsif user_selection == 'n'
      @@player_role = 'breaker'
    else
      select_role
    end
  end

  def select_pegs
    for i in 0..3
      p "Input the color you would like to place at position #{i} and press enter. If your input is not an option, you will have to restart."
      color = gets.chomp.downcase
      if @@peg_options.include?(color)
        @@selected_pegs.push(color)
      else
        select_pegs
      end
    end
  end

  def play_round
    guess_loop if @@player_role == 'breaker'
  end
end

computer_player = Computer.new
human_player = Human.new

human_player.select_role
computer_player.select_role

human_player.play_round
computer_player.play_round
