require 'spec_helper'

describe ShiftSubtitles::Subtitle do

  context "valid subtitle" do

    before(:each) do
      @subtitle = ShiftSubtitles::Subtitle.new("1\n01:31:51,210 --> 01:31:54,893\ntext")    
    end

    it "sets an index on initialization" do
      @subtitle.index.should == '1'
    end

    it "sets the start_time on initialization" do
      @subtitle.start_time.should == '01:31:51,210'
    end

    it "sets the end_time on initialization" do
      @subtitle.end_time.should == '01:31:54,893'
    end

    it "sets the text on initialization" do
      @subtitle.text.should == 'text'
    end

    it "adds 2 seconds to the start_time and end_time" do
      seconds_difference = 2.0
      @subtitle.update_duration(seconds_difference)
      @subtitle.start_time.should == '01:31:53,210'
      @subtitle.end_time.should == '01:31:56,893'
    end

    it "subtracts 1.5 seconds to the start_time and end_time" do
      seconds_difference = -1.5
      @subtitle.update_duration(seconds_difference)
      @subtitle.start_time.should == '01:31:49,710'
      @subtitle.end_time.should == '01:31:53,393'
    end

    it "formats index, start_time, end_time, text for output" do
      formatted_subtitle = @subtitle.format
      formatted_subtitle.should == "1\n01:31:51,210 --> 01:31:54,893\ntext\n\n"
    end

  end

  context "valid subtitle with illegal seconds difference" do

    it "raises an error for negative times" do
      @subtitle = ShiftSubtitles::Subtitle.new("1\n00:00:01,210 --> 00:00:01,893\ntext")
      seconds_difference = -3.0
      lambda { @subtitle.update_duration(seconds_difference) }.should raise_error("Please specify a legal time to shift, this will push the subs into negative values")
    end  

  end

end