require 'spec_helper'

describe ShiftSubtitles::Operation do

  context "operation adds 2 seconds" do

    before(:each) do    
      @operation = ShiftSubtitles::Operation.new({:action => "add", :time => "02,000"})
    end

    it "sets the add action on initialization" do
      @operation.action.should == 'add'    
    end

    it "sets the time on initialization" do
      @operation.time.should == '02,000'    
    end

    it "converts the time and action to a float of the amount of seconds to change" do
      @operation.seconds_difference.should == 2.0
    end

  end

  context "operation subtracts 1.5 seconds" do

    before(:each) do
      @operation = ShiftSubtitles::Operation.new({:action => "subtract", :time => "01,500"})
    end
    
    it "sets the subtract action on initialization" do
      @operation.action.should == 'subtract'    
    end

    it "converts the time and action to a float of the amount of seconds to change" do
      @operation.seconds_difference.should == -1.5
    end

  end
  
  context "invalid scenarios" do
    
    it "nil time passed in on initialization raises an error" do
      lambda { @operation = ShiftSubtitles::Operation.new({:action => "subtract"}) }.should raise_error("Please specify a time to shift")
    end
    
    it "invalid time format 'rogue-time' is passed in on initialization raises an error" do
      lambda { @operation = ShiftSubtitles::Operation.new({:action => "subtract", :time => "rogue_time"}) }.should raise_error("Please specify a valid time to shift")
    end
    
    it "invalid time format '111,889' is passed in on initialization raises an error" do
      lambda { @operation = ShiftSubtitles::Operation.new({:action => "subtract", :time => "111,667"}) }.should raise_error("Please specify a valid time to shift")
    end

    it "invalid 'ssubtractt' action is passed in on initialization raises an error" do
      lambda { @operation = ShiftSubtitles::Operation.new({:action => "ssubtractt", :time => "01,500"}) }.should raise_error("Please specify either 'add' or 'subtract' as the operation")
    end
  
  end

end