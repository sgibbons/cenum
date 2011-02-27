require 'spec_helper'

describe 'enum' do

  before :each do
    @enum = enum :val1, :val2
  end

  it "is a class" do
    @enum.should be_a(Class)
  end

  it "includes its values as constants" do
    @enum.constants.should include(:VAL1)
  end

  describe 'value' do

    it "are Fixnum" do
      @enum::VAL1.should == 0
      @enum::VAL2.should == 1
    end

    it "can be instantiated" do
      val1 = @enum.new(:val1)
      val1.should be_a(@enum)
    end

    describe "instantiated" do

      before :each do
        @val1 = @enum.new(:val1)
        @val2 = @enum.new(:val2)
      end

      it "can be compared" do
        @val1.should == @val1
        @val1.should_not == @val2
        @val1.should < @val2
      end

      it "has value? getter" do
        @val1.should respond_to(:val1?)
        @val1.val1?.should be_true
        @val1.val2?.should be_false
      end

      it "can change its value" do
        @val1.should respond_to(:val2!)
        @val1.val2!
        @val1.should == @val2
      end

      it "can be compared to values" do
        @val1.should == @enum::VAL1
        @val1.should_not == @enum::VAL2
      end

    end # instantiated

  end # value

end # enum
