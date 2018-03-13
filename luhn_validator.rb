module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    sum = 0
    reverse_a = number.to_s.chars.map(&:to_i).reverse!
    reverse_a.each_with_index do |digit, index|
      if index.odd?
        digit *= 2
        digit -= 9 if digit > 9
      end
      sum += digit
    end
    sum.modulo(10).zero?
  end
end
