# Computer which guesses the code for mastermind
class Computer
  def initialize
    @codes = {}
    @correct_digits = []
    @smart_combinations = {}
    @code_permutation = nil
    @stater_codes = [1111, 2222, 3333, 4444, 5555, 6666]
    @found_code = false
  end

  def guess(round)
    if combine_perfect_digits.length == 4
      code = combine_perfect_digits
      @correct_digits = code.chars.map(&:to_i)
      @found_code = true
      Integer(code) 
    elsif @found_code
      @code_permutation ||= create_permutation(@correct_digits)
      last_rounds.join
    else
      @stater_codes[round]
    end
  end

  def send_code_data(code, hints, hash = @codes)
    close = 0
    perfect = 0
    hash[String(code)] =
      hints.to_a.each_with_object([]) do |hint, array| 
        if hint[0] == :close
          hint[1].length.times do |_n|
            close += 1
          end
          array.push(close)
        elsif hint[0] == :perfect
          hint[1].length.times do |_n|
            perfect += 1
          end
          array.push(perfect)
        end
      end
  end

  def combine_perfect_digits 
    @codes.to_a.reduce("") do |joined_code, code_data|
      code_data[1].sum.times do |_n|
        joined_code << code_data[0][0]
      end
      joined_code
    end
  end

  def create_permutation(code)
    code.permutation.to_a.uniq
  end

  def compare_codes
    @codes.each do |code|
      compare_permuation(code)
    end
  end

  def compare_permuation(code)
    @code_permutation.each do |code_permutation|
      comparison = Mastermind.new(0).hint(code[0], code_permutation.join)
      remove_perm(code_permutation) if comparison[:close].length != code[1][0] && comparison[:perfect].length != code[1][1] 
    end
  end

  def remove_perm(permutation)
    @code_permutation.reject! do |perm|
      perm == permutation
    end
  end

  def last_rounds
    compare_codes
    @code_permutation[0]
  end
end
