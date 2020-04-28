module Enumerable
    def my_each
        for i in 0...length
            yield self[i]
        end
    end

    def my_each_with_index
        for i in 0...length
            yield self[i],i
        end
    end
end

testArr=%w(5 6 7)

p "My each test"

testArr.my_each{|number| p number}

p "My each with index test"

testArr.my_each_with_index{|number,index| p "#{number} has index of #{index}"}