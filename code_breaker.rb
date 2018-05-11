class CodeBreaker
  attr_reader :status, :guesses

  def initialize(status)
    @status = status
    @guesses = []
  end

  def make_guess(digits, result = {})
    guess = nil

    if(@status == 'human')
      until(guess)
        puts "Make a guess! "
        new_guess = gets.chomp
        if new_guess.length == digits
          guess = new_guess
        else
          puts "Wrong length"
        end
      end

    elsif(@status == 'cpu')
      if(@guesses.empty?)
        zeroeth_guess = ""
        digits.times { zeroeth_guess << "$" }
        @guesses.push(zeroeth_guess)
      end
      guess = cpu_guess(digits, result)
    end

    return @guesses.push(guess).last
  end

  def cpu_guess(digits, result)
    if(result.nil? || result.empty?)
      result = {}
      to_add = ""
      digits.times { to_add << "X" }
      result[@guesses.last] = to_add
    end

    new_guess = ""
    # go through the last guess, pick something
    possible_digits = cpu_get_correct_digits(result)
    result.each do |guess_digit, result_digit|
      if(result_digit == "●")
        new_guess << guess_digit
      elsif(possible_digits.length > 0)
        # picks from the array of ○ digits
        new_guess << possible_digits.delete(possible_digits.sample)
      else
        new_guess << Array(0..9).sample.to_s
      end
      puts new_guess
    end
    new_guess
  end

  # helper method: returns an array containing the digits that are in the
  # array, but in the wrong location, for the given result of guess
  def cpu_get_correct_digits(result)
    to_return = []
    result.each do |guess_digit, result_digit|
      if(result_digit == "○")
        to_return.push(guess_digit)
      end
    end
    to_return
  end
end
