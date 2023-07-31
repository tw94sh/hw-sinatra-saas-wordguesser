class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    raise ArgumentError, "Input cannot be empty" if letter.nil? || letter.empty?
    raise ArgumentError, "Input must be letter" if !letter.match?(/^[a-z]$/i)

    letter = letter.downcase
    if @word.include?(letter) && !@guesses.include?(letter)
      @guesses = letter + @guesses
    elsif !@wrong_guesses.include?(letter) && !@guesses.include?(letter)
      @wrong_guesses = letter + @wrong_guesses
    else false
    end
  end

  def word_with_guesses
    @word.chars.map{ |letter| @guesses.include?(letter) ? letter : '-' }.join
  end

  def check_win_or_lose
    if @word.chars.all? {|letter| @guesses.include?(letter)}
      :win
    elsif @word.chars.all? {|letter| !@guesses.include?(letter)}
      :lose
    else :play
    end
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
