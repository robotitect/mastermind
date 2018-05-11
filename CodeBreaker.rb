class CodeBreaker
  attr_reader :status

  def initialize(status)
    @status = status
  end

  def make_guess
    puts "Please make a guess! "
    gets.chomp
  end
end
