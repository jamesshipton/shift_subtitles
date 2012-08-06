Given /^"([^"]*)" contains the following$/ do |input_filename, table_lines|
  begin 
    remove_file(input_filename) 
    rescue
  end
  input_file_contents = format_file_contents(table_lines)
  write_file(input_filename, input_file_contents)
end

Then /^"([^"]*)" should contain the following$/ do |output_filename, table_lines|
  expected_output_contents = format_file_contents(table_lines)
  actual_ouput_contents = File.read(File.dirname(__FILE__) + '/../../tmp/aruba/' + output_filename)
  actual_ouput_contents.should == expected_output_contents
end

