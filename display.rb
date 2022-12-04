require_relative "styles"

# rubocop:disable Lint/ConstantResolution

# Text needed for Mastermind
module Display
  DIGIT_PEGS = ["red", "blue", "green", "orange", "purple", "cyan"].freeze
  private_constant :DIGIT_PEGS
  def display_code_prompt 
    "Please enter 4 digits between 1-6."
  end  

  def display_range_warning
    "Invalid code, enter 4 numbers between 1-6.".style("red", "bold")
  end

  def display_computer_winning(tries)
    "The computer cracked the code at round ##{tries}."
  end

  def display_player_winning(tries)
    "#{'Congratulations'.color('green')}, you cracked the code round ##{tries}."
  end

  def display_current_round(round)
    "Currently on round ##{round}.".style("white", "bold")
  end

  def display_secret_code(code)
    "The real secret code is: \n#{color_code(code)}"
  end
  
  def color_code(code)
    digits = String(code).chars
    colored_digits = 
      digits.map do |digit|
        "  #{digit}  ".style(DIGIT_PEGS[Integer(digit) - 1], "background")
      end
    colored_digits.join(" ")
  end

 
end

# rubocop:enable Lint/ConstantResolution