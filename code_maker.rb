require_relative "code_breaker.rb"

class CodeMaker
  attr_reader :code, :status, :digits, :breaker, :results, :turns

  def initialize(status, digits = 4, turns = 12)
    @status = status
    @digits = digits
    @turns = turns
    @results = []
    create_code_and_breaker
  end

  private

  def create_code_and_breaker
    if(@status == "cpu")
      @breaker = CodeBreaker.new("human")
      create_code_random
    elsif(@status == "human")
      @breaker = CodeBreaker.new("cpu")
      create_code_human
    end
  end

  def create_code_random
    new_code = ""
    digits_to_pick_from = Array(0..9)
    @digits.times do
      new_code << digits_to_pick_from.delete(digits_to_pick_from.sample).to_s
    end
    # puts new_code
    @code = new_code
    return new_code
  end

  def create_code_human
    until(@code)
      print "Create a code: "
      new_code = gets.chomp
      if(new_code.split("").uniq.length != new_code.split("").length)
        puts "No duplicates"
      elsif(new_code.length != digits)
        puts "Wrong length"
      else
        @code = new_code
      end
    end
  end

  public

  def play_game
    guess = nil
    i = 0
    until(guess == @code || i >= @turns)
      # puts "Make a guess!"
      result_of_last_guess = @results.last
      guess = breaker.make_guess(@digits, result_of_last_guess)
      result = take_guess(guess)
      print_game_status(result)
      i += 1
    end
  end

  # returns a hash mapping the guess digits to the result
  def take_guess(guess)
    to_return = {}
    to_return.compare_by_identity
    code_array = @code.split("")
    code_array.each_with_index do |code_digit, i|
      if(code_digit == guess[i])
        to_return[guess[i]] = "●"
      elsif(code_array.include?(guess[i]))
      # elsif((results.last.delete_if { |k, v| v == "●" }).keys.include?(guess[i]))
        to_return[guess[i]] = "○"
      else
        to_return[guess[i]] = "X"
      end
    end
    @results.push(to_return)
    to_return
  end

  def print_game_status(result_of_guess)
    puts "● :  correct digit , correct location"
    puts "○ :  correct digit ,   wrong location"
    print "X :    wrong digit ,   wrong location\n\n       |"
    result_of_guess.keys.each do |code_digit|
      print " "
      print code_digit
      print " |"
    end
    print "\n       "
    @digits.times { print "====" }
    print "=\n       |"
    result_of_guess.values.each do |result_digit|
      print " "
      print result_digit
      print " |"
    end
    puts "\n\n"
  end
end
