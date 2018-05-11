require "./CodeBreaker.rb"
require "./CodeMaker.rb"

class Game
  def initialize(breaker_status, maker_status)
    breaker = CodeBreaker.new(breaker_status)
    maker = CodeMaker.new(maker_status)
  end

  def play_game
    puts "Make a "
  end
end
