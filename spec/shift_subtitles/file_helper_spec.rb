require 'spec_helper'

describe ShiftSubtitles::FileHelper do
  
  before(:each) do
    @block = lambda { 'yielded_value' }    
  end

  context "output file" do

    it "yields the block when a file_name & block are passed in" do
      File.should_not_receive(:exists?)
      yielded_value = ShiftSubtitles::FileHelper.operation_with_validation('output', 'filename.txt', &@block)
      yielded_value.should == 'yielded_value'    
    end

    it "raises a invalid file error when no file_name & block are passed in" do
      File.should_not_receive(:exists?)
      lambda { ShiftSubtitles::FileHelper.operation_with_validation('output', nil, &@block) }.should raise_error("Please specify an output file")
    end

  end
  
  context "input file" do
    
    it "yields the block when a file_name & block are passed in" do
      File.should_receive(:exists?).with('filename.txt').and_return(true)
      yielded_value = ShiftSubtitles::FileHelper.operation_with_validation('input', 'filename.txt', &@block)
      yielded_value.should == 'yielded_value'    
    end
    
    it "raises a invalid file error when no file_name is passed in" do
      File.should_not_receive(:exists?)
      lambda { ShiftSubtitles::FileHelper.operation_with_validation('input', nil, &@block) }.should raise_error("Please specify an input file")
    end

    it "raises a file doesn't exist error when an invalid file_name is passed in" do
      File.should_receive(:exists?).with('invalid.txt').and_return(false)
      lambda { ShiftSubtitles::FileHelper.operation_with_validation('input', 'invalid.txt', &@block) }.should raise_error("Please specify a valid input file")
    end
    
  end

end

