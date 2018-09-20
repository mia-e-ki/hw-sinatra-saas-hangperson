class HangpersonGame



  # Get a word from remote "random word" service

 
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
    
    
  # def initialize()
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
    
  def word_with_guesses ()
    to_return = ""
    @word.split('').each do |character|
      if @guesses.include?(character)
        to_return.concat(character)
      else
        to_return.concat("-")
      end
    end
    to_return
  end
    
  def check_win_or_lose ()
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    end
    return :play
  end
  
  
  def guess (letter)
    # Check letter
    if letter.nil?|| !letter.is_a?(String) || !(letter =~ /^[A-Za-z]{1}$/)
      raise ArgumentError 
    end 
    
    # Add letter to correct_guesses or wrong_guesses
    lc = letter.downcase
    if @guesses.include?(lc) || @wrong_guesses.include?(lc)
      return false
    end
    
    
    if @word.include?(lc)
      @guesses.concat(lc)
      return true
    else 
      @wrong_guesses.concat(lc)
      return true
    end
  end 
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

