class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(guess)
    raise ArgumentError if guess.nil?
    guess = guess.downcase 
    
    raise ArgumentError unless guess.is_a?(String) && guess.match?(/\A[a-z]+\z/)

    if @word.include?(guess)
      if @guesses.include?(guess)
        return false
      end
      @guesses << guess
    else
      if @wrong_guesses.include?(guess)
        return false
      end
      @wrong_guesses << guess
    end
  end

  def word_with_guesses
    display_word = ''
    @word.each_char do |char|
      if @guesses.include?(char)
        display_word << char
      else
        display_word << '-'
      end
    end
    return display_word
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >=7
      return :lose
    else
      return :play
    end
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
