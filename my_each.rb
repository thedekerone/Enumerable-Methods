module Enumerable
  def my_each
    array = to_a
    i = 0
    while i < array.size
      return to_enum(:my_each) unless block_given?

      yield array[i]
      i += 1

    end

    self
  end

  def my_each_with_index
    array = to_a
    i = 0
    while i < array.size
      return to_enum(:my_each_with_index) unless block_given?

      yield array[i], i
      i += 1
    end
    self
  end

  def my_select
    new_array = []
    my_each do |element|
      return to_enum(:my_select) unless block_given?

      new_array.push(element) if yield element
    end
    new_array
  end

  def my_all?(compare = nil)
    result = true
    my_each do |element|
      if compare
        result = compare.class.eql?(Class) ? element.is_a?(compare) : element.to_s.match?(compare)
      elsif block_given?
        result = yield element

      else
        bool = !element
        result = !bool
      end
      break unless result
    end

    result
  end

  def my_any?(compare = nil)
    result = true
    my_each do |element|
      if compare
        result = compare.class.eql?(Class) ? element.is_a?(compare) : element.to_s.match?(compare.to_s)
      elsif block_given?
        result = yield element
      else
        bool = !element
        result = !bool
      end
      break if result
    end
    result
  end

  def my_none?(compare = nil)
    result = true
    my_each do |element|
      result = if compare
                 compare.class.eql?(Class) ? !element.is_a?(compare) : !element.to_s.match?(compare)
               elsif block_given?
                 !(yield element)
               else
                 !element
               end
      break unless result
    end
    result
  end

  def my_count(arg = nil)
    counter = 0
    my_each do |element|
      param = if arg
                arg
              elsif block_given?
                yield element
              else
                element
              end
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
                return to_enum(:my_map) unless block_given?

                yield element
              end
      new_arr.push(param)
    end
    new_arr
  end

  def my_inject(initial_value = 0, use = :+)
    if initial_value.is_a?(Symbol)
      use = initial_value

      %i[+ -].include(initial_value) ? 0 : 1
    end

    my_each do |element|
      result = use&.to_proc&.call(initial_value, element)
      result = yield initial_value, element if block_given?
      initial_value = result
    end
    initial_value
  end
end

def multiply_els(array)
  array.my_inject(1) do |acumulator, element|
    acumulator * element
  end
end

# TEST USING THE FOLLOWING CODE

# test_arr = [5, 6, 7]

# p 'My each test'

# test_arr.my_each { |x| p x + 2 }

# p 'My each with index test'

# test_arr.my_each_with_index { |number, index| p "#{number} has index of #{index}" }

# p 'My select test'

# p test_arr.my_select { |x| x != 6 }

# p 'My all test'

# p test_arr.my_all?{|x| x>4}

# p 'My any test'

# p test_arr.my_any?(3)

# p 'My none test'

# p test_arr.my_none?

# p (1..4).my_none?(Numeric)

# p 'My count test'

# p test_arr.my_count(5)

# p 'My map test'
# proc = proc { |element| element }
# p test_arr.my_map

# p 'My inject test'

# p test_arr.my_inject{|x, y| x+y }

# p multiply_el(stest_arr)
