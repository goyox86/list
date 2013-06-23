require 'bundler/setup'
require 'spec_helper'

describe List do
  before do
    @list = List.new
  end

  describe '#new' do
    it 'should always return a new empty List instance' do
      first_list = List.new
      first_list.should be_empty
      second_list = List.new
      second_list.should be_empty
    end
  end

  describe '#insert' do
    it 'should increase the size of the list by 1' do
      lambda {
        @list.insert(2)
      }.should change(@list, :size).from(0).to(1)
    end

    it 'should allow chaining' do
      @list.insert(1).insert(2)
      @list.size.should == 2
    end

    describe 'Empty list' do
      it 'should update the head to the given inserted object' do
        @list.insert(1)
        @list.head.obj.should == 1
      end
    end

    describe 'Non-empty list' do
      it 'should update the head to the given inserted object' do
        @list.insert(1)
        @list.insert(2)
        @list.head.obj.should == 2
      end
    end
  end

  describe '#delete' do
    it 'should decrease the size of the list by 1' do
      @list.insert(2)
      lambda {
        @list.delete(2)
      }.should change(@list, :size).from(1).to(0)
    end

    describe 'Empty list' do
      it 'should return nil' do
        @list.delete(1).should be_nil
      end
    end

    describe '1-element list' do
      it 'should remove the given element from the List' do
        @list.insert(1)
        @list.delete(1) == 1
        @list.find(1).should be_nil
      end

      it 'should return the element element being deleted' do
        @list.insert(1)
        @list.delete(1).should == 1
      end
    end

    describe 'n-elements list' do
      it 'should remove the given element from the List' do
        @list.insert(1)
        @list.insert(2)
        @list.delete(2)
        @list.find(2).should be_nil
      end

      it 'should return the element element being deleted' do
        @list.insert(1)
        @list.insert(2)
        @list.delete(2).should  == 2
      end
    end
  end

  describe '#each' do
    it 'should yield each element' do
      first_element = 'foo'
      second_element = 'bar'
      @list.insert(first_element)
      @list.insert(second_element)
      first_element.should_receive(:to_s)
      second_element.should_receive(:to_s)

      @list.each { |element| element.obj.to_s }
    end
  end

  describe '#find' do
    it 'should return nil when no element is found' do
      @list.find('non-existen-element').should be_nil
    end

    it 'should return the given element' do
      @list.insert('foo')
      @list.insert('bar')
      @list.insert('baz')
      @list.find('foo').obj.should == 'foo'
    end
  end

  describe '#reverse!' do
    describe 'Empty list' do
      it 'should return a reference to self' do
        @list.reverse!.should == @list
      end
    end

    describe '1-element list' do
      it 'should return a reference to self' do
        @list.insert(1)
        @list.reverse!.should == @list
      end

      it 'should return the unique element present' do
        @list.insert(1)
        @list.reverse!
        @list.delete_front.should == 1
      end
    end

    describe 'n-elements list' do
      it 'should return a reference to self' do
        @list.insert(1)
        @list.insert(2)
        @list.insert(3)
        @list.insert(4)
        @list.reverse!.should == @list
      end

      it 'should reverse the order of elements' do
        @list.insert(1)
        @list.insert(2)
        @list.insert(3)
        @list.insert(4)
        @list.reverse!
        @list.delete_front.should == 1
        @list.delete_front.should == 2
        @list.delete_front.should == 3
        @list.delete_front.should == 4
      end
    end
  end

  describe '#recursive_reverse!' do
    describe 'Empty list' do
      it 'should return a reference to self' do
        @list.recursive_reverse!.should == @list
      end
    end

    describe '1-element list' do
      it 'should return a reference to self' do
        @list.insert(1)
        @list.recursive_reverse!.should == @list
      end

      it 'should return the unique element present' do
        @list.insert(1)
        @list.recursive_reverse!
        @list.delete_front.should == 1
      end
    end

    describe 'n-elements list' do
      it 'should return a reference to self' do
        @list.insert(1)
        @list.insert(2)
        @list.insert(3)
        @list.insert(4)
        @list.reverse!.should == @list
      end

      it 'should reverse the order of elements' do
        @list.insert(1)
        @list.insert(2)
        @list.insert(3)
        @list.insert(4)
        @list.recursive_reverse!
        @list.delete_front.should == 1
        @list.delete_front.should == 2
        @list.delete_front.should == 3
        @list.delete_front.should == 4
      end
    end
  end

  describe '#empty?' do
    it 'should return true when the list has no elements' do
      @list.should be_empty
    end

    it 'should return false when the list has a least one element' do
      @list.insert(1)
      @list.should_not be_empty
    end
  end

  describe '#delete_front' do
    it 'should decrease the size of the list by 1' do
      @list.insert(2)
      lambda {
        @list.delete_front
      }.should change(@list, :size).from(1).to(0)
    end

    describe 'Empty list' do
      it 'should return nil' do
        @list.delete_front.should be_nil
      end
    end

    describe '1-element list' do
      it 'should remove the element referenced by the head returning a reference to it' do
        @list.insert(1)
        @list.delete_front.should == 1
      end
    end

    describe 'n-elements list' do
      it 'should remove the element referenced by the head on each call returning a reference to it' do
        @list.insert(1)
        @list.insert(2)
        @list.insert(3)
        @list.insert(4)
        @list.delete_front.should == 4
        @list.delete_front.should == 3
        @list.delete_front.should == 2
        @list.delete_front.should == 1
      end
    end
  end
end