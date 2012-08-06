require 'spec_helper'

describe ShiftSubtitles::Process do

  context "valid input" do

    it "reads in the output file name and creates the file" do
      options = {:action => "add", :time => "2,000", :input => "input.srt", :output => "output.srt"}
      mock_operation = mock(ShiftSubtitles::Operation, :seconds_difference => 2.0)
      mock_subtitles = mock(ShiftSubtitles::Subtitles, :formatted_subtitles => 'formatted_subtitles')
      ShiftSubtitles::Operation.should_receive(:new).with(options).and_return(mock_operation)
      ShiftSubtitles::Subtitles.should_receive(:new).with(options).and_return(mock_subtitles)      
      file_block = lambda { File.open(options[:output], 'w') { |file| file << mock_subtitles.formatted_subtitles_for_file } }      
      ShiftSubtitles::FileHelper.should_receive(:operation_with_validation).with('output', options[:output], &file_block)
      mock_subtitles.should_receive(:update_subtitles).with(2.0)    
      mock_operation.should_receive(:seconds_difference).with()
      mock_subtitles.should_receive(:formatted_subtitles_for_file).with()
      ShiftSubtitles::Process.shift_subtitles(options)
    end

  end

  context "invalid input" do

    it "fails when no output file is specified" do    
      options = {:action => "add", :time => "2,000", :input => "input.srt"}
      mock_operation = mock(ShiftSubtitles::Operation, :seconds_difference => 2.0)
      mock_subtitles = mock(ShiftSubtitles::Subtitles)
      ShiftSubtitles::Operation.should_receive(:new).with(options).and_return(mock_operation)
      ShiftSubtitles::Subtitles.should_receive(:new).with(options).and_return(mock_subtitles)    
      file_block = lambda { File.open(nil, 'w') { |file| file << mock_subtitles.formatted_subtitles_for_file } }      
      ShiftSubtitles::FileHelper.should_receive(:operation_with_validation).with('output', nil, &file_block)
      mock_subtitles.should_receive(:update_subtitles).with(2.0)    
      mock_operation.should_receive(:seconds_difference).with()
      mock_subtitles.should_not_receive(:formatted_subtitles_for_file)

      lambda { ShiftSubtitles::Process.shift_subtitles(options) }.should raise_error
    end

  end

end