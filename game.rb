require_relative "code"
require_relative "styles"
require_relative "display"
require_relative "computer_player"

# Guess a code from 0-6 or let the computer do the guessing by choosing to be the BREAKER or MAKER
class Mastermind
  include ::Code
  include ::Display

  def initialize(mode)
    @rounds = 12
    @mode = mode
    @code =
      if @mode == 1
        player_code_input 
      else
        generate_code
      end
  end

  def play
    computer = Computer.new
    12.times do |n|
      puts(display_current_round(n + 1))
      if @mode == 2
        code = player_code_input 
        puts("#{color_code(code)}\t   #{pretty_hint(hint(@code, code))}")
        if code == @code
          puts(display_player_winning(n + 1))
          break
        else
          next
        end 
      else
        code = Integer(computer.guess(n))
        hint = hint(@code, code)
        puts("#{color_code(code)}\t   #{pretty_hint(hint)}")
        if code == @code
          puts(display_computer_winning(n + 1))
          break
        else
          computer.send_code_data(code, hint)
          sleep(0.5)
          next
        end 
      end
    end
    puts(display_secret_code(@code))
  end
  
  def hint(master_code, code)
    hints = { close: [], perfect: [] }
    code_digits = String(code).chars
    correct_code_digits = String(master_code).chars
    tagged_correct_code = tag_up_digits(correct_code_digits)
    tagged_code = tag_up_digits(code_digits)

    # On the spot
    code_digits.each_with_index do |digit, index|
      next unless digit == correct_code_digits[index]

      hints[:perfect].push(digit) 
      tag_digit(index, tagged_code)
      tag_digit(index, tagged_correct_code)
    end

    # Close
    code_digits.each_with_index do |digit, index|
      next unless correct_code_digits.find_index(digit) && !tagged_digit?(
        index, 
        tagged_code
      ) && tagged_correct_code.each_with_index.any? do |digit1, index1|
             !tagged_digit?(index1, tagged_correct_code) if digit == digit1[0]
           end
        
      hints[:close].push(digit) 
      tag_digit(index, tagged_code)
      tag_digit(
        tagged_correct_code.each_with_index.find_index do |digit1, index1|
          !tagged_digit?(index1, tagged_correct_code) if digit == digit1[0]
        end, 
        tagged_correct_code
      )
    end
    
    hints
  end

  private
  
  def pretty_hint(hint)
    close = 
      hint[:close].reduce("") do |string, hints|
        string << ("O" * hints.length).mode("bold")
      end

    perfect =
      hint[:perfect].reduce("") do |string, hints|
        string << ("X" * hints.length).style("orange", "bold")
      end
    perfect << close
  end

  def tagged_digit?(index, tagged_code)
    tagged_code[index][1] == true
  end

  def tag_digit(index, tagged_code)
    tagged_code[index][1] = true
  end

  def tag_up_digits(digits)
    digits.map { |digit| [digit, false] }
  end
end
