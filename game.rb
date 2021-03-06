require_relative "guesser.rb"
require_relative "comp_guesser.rb"

module MasterMind

  def self.check_input(reg_exp)
    str = gets.strip
    until reg_exp === str
      puts "Invalid input. Try again: "
      str = gets.strip
    end
    str
  end

  puts "Do you want battle with computer? (y/n)"
  answer = check_input(/^[yYnN]{1}$/)

  game = Guesser.new
  comp = CompGuesser.new
    
  if answer == 'y'
    # p game.secret # show secret code
    puts '== BATTLE HUMAN-COMPUTER == 
The task is to guess code of 4 numbers from 6: 1,2,3,4,5,6'
    counter = 0
    while game.bulls < 4 && counter < 12
      if counter.even?
        guess = game.guessing
        counter += 1
        game.feedback(guess)
      else
        comp.guess = guess.split('').map(&:to_i)
        comp.combinations
        comp.guess = comp.generate_guess
        guess = comp.guess.join
        game.feedback(guess)
        comp.combinations
        counter += 1
        game.display
      end
    puts '------------------------------'
    end
    if game.bulls == 4
      puts counter.even? ? "Computer won!" : "Human won!"
    else 
      puts "Game is over. Unfortunately noone guessed"
    end
  else
    puts "Do you want to be codemaker? (y/n)"
    answer = check_input(/^[yYnN]{1}$/)
    
    if answer == 'y'
      puts "Make the code of 4 numbers from 6 (1-6): "
      code = check_input(/^[1-6]{4}$/)      
      counter = 0
      while game.bulls < 4 && counter < 12
        puts "Computer thinks number is #{comp.guess.join}"
        puts "Compare with your number: #{code}"
        puts "BullsCows: "
        bc = check_input(/^[0-4]{2}$/)
        game.bulls = bc[0].to_i
        game.cows = bc[1].to_i
        comp.combinations
        comp.guess = comp.generate_guess
      end
      puts game.bulls == 4 ? "Computer won!" : "Game is over. Unfortunately computer didn't guess"
    else
      puts 'The task is to guess secret code of 4 numbers from 6: 1,2,3,4,5,6'
      counter = 0
      while game.bulls < 4 && counter < 12
        guess = game.guessing
        counter += 1
        game.feedback(guess)
        game.display
      end
      puts game.bulls == 4 ? "You won!" : "Game is over. Unfortunately you didn't guess. Secret code is #{game.secret}"
    end
  end
end
