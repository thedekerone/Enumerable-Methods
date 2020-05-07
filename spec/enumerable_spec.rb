require './my_each.rb'

describe Enumerable do
    let (:array) {Array.new([1,2,3])}
    let (:wrong_type) {"wrong"}
    
    describe "#my_each" do
        context "when applied block of code" do
            it "must return the same array" do
                expect(array.my_each{|x| x+2}).to eql(array)
            end
    
            it "must execute for every element" do
                testArray=[]
                array.my_each{|x| testArray.push(x+2)}
                expect(testArray).to eql([3,4,5])
            end
        end

        it "if not block given" do
            expect(array.my_each).to be_a(Enumerator)
        end

        it "Wrong type error" do
            expect { wrong_type.my_each }.to raise_error(NoMethodError)
        end
    end
    
    describe "#my_each_with_index" do

        context "when applied block of code" do
            it "must return the same array" do
                expect(array.my_each_with_index{|x, i| x+2}).to eql(array)
            end
    
            it "must execute for every element" do
                testArray=[]
                array.my_each_with_index{|x| testArray.push(x+2)}
                expect(testArray).to eql([3,4,5])
            end
    
            it "must have a index parameter" do
                testArray=[]
                array.my_each_with_index{|x,i| testArray.push(i)}
                expect(testArray).to eql([0,1,2])
            end
        end

        it "if not block given" do
            expect(array.my_each_with_index).to be_a(Enumerator)
        end

        it "Wrong type error" do
            expect { wrong_type.my_each_with_index }.to raise_error(NoMethodError)
        end


    end
end