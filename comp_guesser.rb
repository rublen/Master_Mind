module MasterMind

  class CompGuesser < Guesser
    NUMS = [1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6]
    
    attr_accessor :guess
    
    def initialize
      @guess = [1, 1, 2, 2]
      @combs = NUMS.combination(4).to_a.uniq
    end
    
    def generate_guess
       @guess = @combs[rand(@combs.length)]
    end
    
    def combinations
      if @@bulls + @@cows != 0
        @combs.delete_if { |comb| bulls_amount(comb) < @@bulls }
        @combs.delete_if { |comb| bulls_and_cows(comb) < @@bulls + @@cows }
        @combs.delete_if { |comb| bulls_and_cows(comb) != 4 } if @@bulls + @@cows == 4
        @combs.delete_if { |comb| bulls_amount(comb) != 0 } if @@bulls == 0
        @combs.delete_if { |comb| cows_amount(comb) != 0 } if @@cows == 0
        @combs.delete_if { |comb| @guess.any? { |n| comb.count(n) > 1 } } if @@bulls + @@cows == 1
      else
        @combs.delete_if { |comb| bulls_and_cows(comb) != 0 }
      end  
      @combs.delete(@guess) if @combs.size > 1
    end

    private
    
    def bulls_amount(comb)
      counter = 0
      (0..3).each { |i| counter += 1 if comb[i] == @guess[i] }
      counter
    end
    
    def bulls_and_cows(comb)
      comb_copy = comb.dup
      counter = 0
      (0..3).each do |i|
        if ind = comb_copy.find_index { |num| num == @guess[i] }
          counter += 1
          comb_copy[ind] = 'X'
        end
      end
      counter
    end
    
    def cows_amount(comb)
       bulls_and_cows(comb) - bulls_amount(comb)
    end
  
  end
  
end
        