require_relative "display"
require_relative "styles"

# Gets a colored 4 digit code from the player or computer
module Code
  include ::Display

  def player_code_input
    puts(display_code_prompt)
    code = Integer(gets.chomp)
  rescue ::StandardError
    puts(display_range_warning)
    retry
  else
    if check_code(code) 
      code
    else
      puts(display_range_warning)
      player_code_input
    end
  end
  
  def check_code(code)
    code = code.floor.to_s
    four_digits = code.length == 4
    between_one_six = code.chars.all? { |n| Integer(n).between?(1, 6) }
    four_digits && between_one_six
  end

  def generate_code
    code = ""
    4.times { code << String(rand_range(1, 6)) }
    Integer(code)
  end

  def rand_range(min, max)
    until min - 1 < r = rand(max + 1); end
    r
  end
end
