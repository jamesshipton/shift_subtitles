module ShiftSubtitles

  class Subtitles

    include Enumerable

    attr_accessor :subtitle_list

    def initialize options
      input_file_subtitles = input_file_contents(options[:input]).scan(input_file_pattern)
      @subtitle_list = input_file_subtitles.collect { |subtitle| ShiftSubtitles::Subtitle.new(subtitle) }
    end

    def each
      @subtitle_list.each {|subtitle| yield(subtitle)}
    end

    def update_subtitles seconds_difference
      each { |subtitle| subtitle.update_duration(seconds_difference) }
    end

    def formatted_subtitles_for_file
      collect { |subtitle| subtitle.format }.join
    end

    def input_file_contents input_file_path
      ShiftSubtitles::FileHelper.operation_with_validation('input', input_file_path) { File.read(input_file_path) }
    end

    def input_file_pattern
      /[0-9]+\n[0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3} --> [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}\n.*/
    end
    
  end

end