class CodeMaker
  attr_reader :code, :status

  def initialize(status)
    @status = status
    if(status == 'human')
      puts "You are the CodeBreaker"
    else
      puts "How many digits?"
      digits = gets.chomp.to_i
      create_code_random(digits, 1..digits)
    end
  end

  def create_code_random(digits, range)
    new_code = ""
    digits.times do
      new_code << rand(range)
    end
    @code = new_code
  end

  def take_guess(guess)
    to_return = ""
    @code.each_with_index do |code_digit, i|
      if(code_digit == guess[i])
        to_return << "●"
      elsif(@code.include?(guess[i]))
        to_return << "○"
      else
        to_return << "X"
      end
    end
    to_return
  end
end
