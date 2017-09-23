module MasterMind
  COLORES = [ 1, 2, 3, 4, 5, 6 ]
  
  class Guesser
    @@bulls = 0
    @@cows = 0
    
    attr_reader :secret
    
    def initialize
      @secret = Array.new(4) { |x| x = COLORES[rand(6)] }.join
      @guesses = []
    end
    
    def bulls; @@bulls; end
      
    def bulls=(n); @@bulls = n end
      
    def cows=(n); @@cows = n end
      
    def guessing
      puts 'Try to guess secret code: '
      guess = MasterMind::check_input(/^[1-6]{4}$/)       
    end
    
    def feedback(str)
      @@cows = 0
      @@bulls = 0
      secret = @secret.dup
      s = str.dup
      (0...4).each do |i|
        if s[i] == secret[i]
          @@bulls += 1
          secret[i] = 'X'
          s[i] = 'Y'
        end
      end
      (0...4).each do |i|
        if secret.include?(s[i])
          @@cows += 1
          secret.sub!(s[i], 'Z')
        end
      end
      @guesses << "#{str} | Bulls: #{@@bulls} | Cows: #{@@cows} |"
    end
    
    def display
      @guesses.each_with_index { |guess, ind| puts "%2d" % (ind + 1) + ". #{guess}" }
    end
    
  end
  
end
