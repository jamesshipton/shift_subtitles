require 'time'

  module ShiftSubtitles

  class Subtitle

    attr_reader :index, :start_time, :end_time, :text

    def initialize subtitle_string
      subtitle_pattern =~ subtitle_string
      @index, @start_time, @end_time, @text = $1, $2, $3, $4
    end

    def update_duration seconds_difference
      @start_time = update_time(start_time, seconds_difference)
      @end_time = update_time(end_time, seconds_difference)
    end
    
    def update_time time_string, seconds_difference
      time = Time.parse(time_string)
      updated_time = Time.parse(time_string) + seconds_difference
      raise("Please specify a legal time to shift, this will push the subs into negative values") if updated_time.day < time.day
      updated_time.strftime("%H:%M:%S,%L")
    end

    def format
      "#{index}\n#{start_time} --> #{end_time}\n#{text}\n\n"
    end
    
    def subtitle_pattern
      /([0-9]+)\n([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}) --> ([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3})\n(.*)/      
    end

  end

end