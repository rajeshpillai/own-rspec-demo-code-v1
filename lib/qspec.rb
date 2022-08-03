GREEN = "\e[32m"
RED   = "\e[31m"
RESET = "\e[0m"

class QSpec 
  def self.describe (desc, &block) 
    puts desc.upcase
    instance_eval &block # &block is now a block and not a proc
 end

  def self.it (desc, &block)
    begin
      puts " - #{desc}"
      result = instance_eval &block # &block is now a block and not a proc
      puts " #{GREEN}(ok)#{RESET}"
    rescue Exception => e 
      puts "#{RED}(fail)#{RESET}"
    end
  end

  def self.expect (value)  
    Expectation.new(value)
  end

  def self.eq (expected)
    Matcher::Equal.new(expected)
  end

  def self.is_equal(expected, actual)
    unless actual == expected 
      raise AssertionError.new
        ("Expected #{expected.inspect} but got #{actual.inspect}"
        )
      end
    end
end

# separate file
class Object 
  def should
    ComparisonAssertion.new(self)
  end
end

class Expectation
  def initialize (value)
    @actual = value
  end

  def to (matcher)
    matcher.run(@actual)
  end
end

class Matcher 
  class Equal 
    def initialize(expected) 
      @expected = expected
    end

    def run (actual) 
      unless actual == @expected
        raise AssertionError.new(
          "Expected #{@expected.inspect} but got #{actual.inspect}"
        )
      end   
    end
  end
end


class ComparisonAssertion
  def initialize (actual)
    @actual = actual
  end

  def ==(expected)
    unless @actual == expected
      raise AssertionError.new(
        "Expected #{expected.inspect} but got #{@actual.inspect}"
      )
    end
  end

  def !=(expected)
    unless @actual != expected
      raise AssertionError.new(
        "Expected #{expected.inspect} but got #{@actual.inspect}"
      )
    end
  end
end

class AssertionError < RuntimeError

end





