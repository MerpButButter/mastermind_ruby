require_relative "code"
require_relative "styles"
require_relative "display"
require_relative "game"

def play
  game_mode
  puts("Press 'y' if you want to play again or 'n' to stop ")
  input = gets.chomp
  if input == "y"
    play
  else
    puts("Thanks for playing!".style("orange", "bold"))
  end
end

def game_mode
  puts(game_mode_prompt)
  input = gets.chomp
  if input == "1" 
    ::Mastermind.new(1).play
  elsif input == "2"
    ::Mastermind.new(2).play
  else
    puts("Please enter a number between 1 and 2.".color("red"))
    game_mode
  end
end

def game_mode_prompt
  "Enter #{'1'.color('red')} to be the #{'MAKER'.color('red')}\nOR Enter #{'2'.color('blue')} to be the #{'BREAKER'.color('blue')}"
end

play
