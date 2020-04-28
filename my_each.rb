module Enumerable
    def my_each
        for i in 0...length
            yield self[i]
        end
        self
    end

    def my_each_with_index
        for i in 0...length
            yield self[i],i
        end
        self
    end

    def my_select
        new_array=[]
        my_each do |element| 
            if(yield element)
                new_array.push(element)
            end
        end
        new_array
    end

    def my_all?
        result = true
        my_each do |element| 
            if block_given?
                statement=yield element
            else
                statement=element
            end
             
            if(!statement)
                result=false
                break;
            end
            
            result= true
        end
        result
    end

    def my_any?
        result = true
        my_each do |element| 
            if block_given?
                statement=yield element
            else
                statement=element
            end
             
            if(statement)
                result=true
                break;
            end
            result= false
        end
        result
    end

    def my_none?
        !my_any? do |element|
            yield element
        end
    end

    def my_count
        counter=0
        my_each do |element|
            param = yield element
            if(param.eql?(true) || param.eql?(element))
                counter+=1
            end
        end
        counter
    end

    def my_map(proc=nil)
        newArr=[]
        my_each do |element|
            if (proc)
                param = proc.call(element)
            else
                param = yield element
            end
            newArr.push(param)
        end
        newArr
    end

    def my_inject(initial_value=0)
        acumulator=initial_value
        my_each do |element|
            result = yield element, acumulator
            acumulator= result
        end
        acumulator
    end

    def multiply_els
        my_inject(1) do |acumulator, element|
            acumulator*element
        end
    end

end

testArr=[5,6,7]

# p "My each test"

# p testArr.my_each{|test|  test}

# p "My each with index test"

# testArr.my_each_with_index{|number,index| p "#{number} has index of #{index}"}

# p "My select test"

# p testArr.my_select{|number| number!=(6)}

# p "My all test"

# p testArr.my_all?{|number| number>3}

# p "My any test"

# p testArr.my_any?{|number| number}

# p "My none test"

# p testArr.my_none?{|number| number>7}

# p "My count test"

# p testArr.my_count{|number| number>5}

# p "My map test"
# proc= Proc.new {|element| element}
# p testArr.my_map(proc){|number| number+5}

# p "My inject test"

# p testArr.multiply_els

# t = Proc.new {|element| element}

# p testArr.my_map{|number| t.call(number)}
