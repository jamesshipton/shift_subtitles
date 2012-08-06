require 'spec_helper'

describe Numeric do
  
  it "converts a 1 minute into 60 seconds" do
    1.minutes_to_secs.should == 60
  end
  
  it "converts a 1 hour into 3600 seconds" do
    1.hours_to_secs.should == 3600
  end
  
end