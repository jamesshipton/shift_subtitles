require 'spec_helper'

describe ShiftSubtitles::Subtitles do

  context "a file with 1 subtitle is input" do

    before(:each) do
      input_file_contents = "1\n01:31:51,210 --> 01:31:54,893\ntext"
      @mock_subtitle = mock(ShiftSubtitles::Subtitle)
      @seconds_difference = 2.0
      File.should_receive(:read).with('input.srt').and_return(input_file_contents)      
      file_block = lambda { File.read('input.srt') }
      ShiftSubtitles::FileHelper.should_receive(:operation_with_validation).with('input', 'input.srt', &file_block)
      ShiftSubtitles::Subtitle.should_receive(:new).once.with("1\n01:31:51,210 --> 01:31:54,893\ntext").and_return(@mock_subtitle)
      @subtitles = ShiftSubtitles::Subtitles.new({:input => 'input.srt'}) 
    end

    it "is initialized with a file containing 1 subtitle" do
      @subtitles.subtitle_list.count.should == 1    
    end

    it "includes the Enumerable each method to access the subtitle_list" do
      @subtitles.count.should == 1
    end

    it "updates each subtitle using the Operation" do
      @mock_subtitle.should_receive(:update_duration).with(@seconds_difference)
      updated_subtitles = @subtitles.update_subtitles(@seconds_difference)
    end

    it "formats the subtitles for output" do
      @mock_subtitle.should_receive(:format).once.and_return("1\n01:31:51,210 --> 01:31:54,893\ntext\n\n")
      formatted_subtitles = @subtitles.formatted_subtitles_for_file
      formatted_subtitles.should == "1\n01:31:51,210 --> 01:31:54,893\ntext\n\n"
    end

  end

  context "a file with 2 subtitles is input" do

    before(:each) do
      input_file_contents = "1\n01:31:51,210 --> 01:31:54,893\ntext\n\n2\n01:31:54,210 --> 01:31:57,893\nmore text\n\n\n"
      @mock_subtitle = mock(ShiftSubtitles::Subtitle)
      @seconds_difference = 2.0
      File.should_receive(:read).with('input.srt').and_return(input_file_contents)
      file_block = lambda { File.read('input.srt') }
      ShiftSubtitles::FileHelper.should_receive(:operation_with_validation).with('input', 'input.srt', &file_block)
      ShiftSubtitles::Subtitle.should_receive(:new).once.with("1\n01:31:51,210 --> 01:31:54,893\ntext").and_return(@mock_subtitle)
      ShiftSubtitles::Subtitle.should_receive(:new).once.with("2\n01:31:54,210 --> 01:31:57,893\nmore text").and_return(@mock_subtitle)
      @subtitles = ShiftSubtitles::Subtitles.new({:input => 'input.srt'}) 
    end

    it "is initialized with a file containing 2 subtitles" do
      @subtitles.subtitle_list.count.should == 2    
    end

  end
  
  context "invalid input file" do

    it "is initialized with no file" do
      ShiftSubtitles::FileHelper.should_receive(:operation_with_validation).and_raise
      lambda { ShiftSubtitles::Subtitles.new({:input => nil}) }.should raise_error
    end
    
    it "is initialized with an invalid filename" do
      ShiftSubtitles::FileHelper.should_receive(:operation_with_validation).and_raise
      lambda { ShiftSubtitles::Subtitles.new({:input => 'dud'}) }.should raise_error    
    end
  end
  
end