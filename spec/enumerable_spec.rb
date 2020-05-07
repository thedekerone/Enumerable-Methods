require './my_each.rb'

describe Enumerable do
  let(:array) { Array.new([1, 2, 3]) }
  let(:wrong_type) { 'wrong' }

  describe '#my_each' do
    context 'when applied block of code' do
      it 'must return the same array' do
        expect(array.my_each { |x| x + 2 }).to eql(array)
      end

      it 'must execute for every element' do
        test_array = []
        array.my_each { |x| test_array.push(x + 2) }
        expect(test_array).to eql([3, 4, 5])
      end
    end

    it 'if not block given' do
      expect(array.my_each).to be_a(Enumerator)
    end

    it 'Wrong type error' do
      expect { wrong_type.my_each }.to raise_error(NoMethodError)
    end
  end

  describe '#my_each_with_index' do
    context 'when applied block of code' do
      it 'must return the same array' do
        expect(array.my_each_with_index { |x, _i| x + 2 }).to eql(array)
      end

      it 'must execute for every element' do
        test_array = []
        array.my_each_with_index { |x| test_array.push(x + 2) }
        expect(test_array).to eql([3, 4, 5])
      end

      it 'must have a index parameter' do
        test_array = []
        array.my_each_with_index { |_x, i| test_array.push(i) }
        expect(test_array).to eql([0, 1, 2])
      end
    end

    it 'if not block given' do
      expect(array.my_each_with_index).to be_a(Enumerator)
    end

    it 'Wrong type error' do
      expect { wrong_type.my_each_with_index }.to raise_error(NoMethodError)
    end
  end

  describe '#my_select' do
    context 'When the block is given' do
      it 'return Array with true condition in block' do
        expect(array.my_select { |x| x >= 2 }).to eql([2, 3])
      end

      it 'return Array when the range is provided ' do
        expect((1...4).my_select { |x| x >= 2 }).to eql([2, 3])
      end
    end

    it 'if not block given' do
      expect(array.my_select).to be_a(Enumerator)
    end

    it 'Wrong type error' do
      expect { wrong_type.my_select }.to raise_error(NoMethodError)
    end
  end
  describe '#my_all?' do
    context 'When the block is given' do
      it 'every element matches the condition in block' do
        expect(array.my_all? { |x| x >= 0 }).to eql(true)
      end

      it 'not every elements matches the condition in block' do
        expect(array.my_all? { |x| x > 1 }).to eql(false)
      end
    end

    context 'When the block is not given and parameter is given:' do
      it 'regex' do
        expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
      end
      it 'Class' do
        expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
      end
    end
    context 'When the neither the block or parameter is given' do
      it 'the array is empty' do
        expect([].my_all?).to eql(true)
      end
      it 'the array is not empty' do
        expect([nil, true, 99].my_all?).to eql(false)
      end
    end
  end
end
