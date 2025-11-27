class SimpleCalculator
  class UnsupportedOperation < StandardError
  end
  @@ALLOWED_OPERATIONS = ['+', '/', '*'].freeze
  def self.calculate(first_operand, second_operand, operation)
    if (!@@ALLOWED_OPERATIONS.include?(operation))
      raise UnsupportedOperation.new("\"#{operation}\" not in [#{@@ALLOWED_OPERATIONS.join(',')}]") 
    end

    if(!first_operand.is_a?(Numeric) || !second_operand.is_a?(Numeric)) 
      raise ArgumentError.new("Both operands must be numbers")
    end

    if (operation == '/' && second_operand == 0)
      return "Division by zero is not allowed."
    end

    exp = "#{first_operand} #{operation} #{second_operand}"
    ans = eval(exp)
    exp + " = #{ans}"
  end
end
