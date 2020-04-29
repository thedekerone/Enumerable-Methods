module Enumerable
  def my_each
    (0...length).each do |i|
      yield self[i]
    end
    self
  end

  def my_each_with_index
    (0...length).each do |i|
      yield self[i], i
    end
    self
  end

  def my_select
    new_array = []
    my_each do |element|
      new_array.push(element) if yield element
    end
    new_array
  end

  def my_all?
    result = true
    my_each do |element|
      statement = if block_given?
                    yield element
                  else
                    element
                  end

      unless statement
        result = false
        break
      end

      result = true
    end
    result
  end

  def my_any?
    result = true
    my_each do |element|
      statement = if block_given?
                    yield element
                  else
                    element
                  end

      if statement
        result = true
        break
      end
      result = false
    end
    result
  end

  def my_none?
    !my_any? do |element|
      yield element
    end
  end

  def my_count
    counter = 0
    my_each do |element|
      param = yield element
      counter += 1 if param.eql?(true) || param.eql?(element)
    end
    counter
  end

  def my_map(proc = nil)
    new_arr = []
    my_each do |element|
      param = if proc
                proc.call(element)
              else
                yield element
              end
      new_arr.push(param)
    end
    new_arr
  end

  def my_inject(initial_value = 0)
    acumulator = initial_value
    my_each do |element|
      result = yield element, acumulator
      acumulator = result
    end
    acumulator
  end

  def multiply_els
    my_inject(1) do |acumulator, element|
      acumulator * element
    end
  end
end

# TEST USING THE FOLLOWING CODE

# test_arr = [5, 6, 7]

# p 'My each test'

# test_arr.my_each { |test| p test + 3 }

# p 'My each with index test'

# test_arr.my_each_with_index { |number, index| p "#{number} has index of #{index}" }

# p 'My select test'

# p test_arr.my_select { |number| number != 6 }

# p 'My all test'

# p test_arr.my_all? { |number| number > 3 }

# p 'My any test'

# p test_arr.my_any? { |number| number }

# p 'My none test'

# p test_arr.my_none? { |number| number > 7 }

# p 'My count test'

# p test_arr.my_count { |number| number > 5 }

# p 'My map test'
# proc = proc { |element| element }
# p test_arr.my_map(proc) { |number| number + 5 }

# p 'My inject test'

# p test_arr.multiply_els
