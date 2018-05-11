require_relative "code_maker.rb"

puts "Welcome to MasterMind"

print "How many digits? "
print "4" # TODO: change to gets
digits = 4
# digits = gets.chomp.to_i
puts
print "How many turns? "
print "100" # TODO: change to gets later
turns = 100
# turns = gets.chomp.to_i
puts "\n"


maker = CodeMaker.new("cpu", digits, turns)
maker.play_game
