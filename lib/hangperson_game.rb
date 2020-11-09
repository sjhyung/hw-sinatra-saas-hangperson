class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word , :guesses , :wrong_guesses
  
  def initialize(new_word)
    @word = new_word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError.new('letter must exist please input the exist letter') if letter==nil || letter.empty?
    raise ArgumentError.new('letter must be alphabet please input the alphabetic letter') if !letter.match(/[a-zA-Z]/) 
    letter.downcase!
    return false if (@guesses + @wrong_guesses).include? letter
    @guesses += letter if @word.include? letter
    @wrong_guesses += letter if !@word.include? letter
  end
  
  def word_with_guesses
   wwg = ''
   @word.split('').each do |letter|
    wwg+=letter if @guesses.include? letter
    wwg+='-' if !@guesses.include? letter
   end
    return wwg
  end

  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7
    return :play
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end