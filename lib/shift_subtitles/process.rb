module ShiftSubtitles

  module Process

    def self.shift_subtitles options
      operation = ShiftSubtitles::Operation.new(options)
      subtitles = ShiftSubtitles::Subtitles.new(options)
      subtitles.update_subtitles(operation.seconds_difference)
      create_and_populate_output_file(options[:output], subtitles)
    end

    def self.create_and_populate_output_file output_file_name, subtitles
      ShiftSubtitles::FileHelper.operation_with_validation('output', output_file_name) do 
        File.open(output_file_name, 'w') { |file| file << subtitles.formatted_subtitles_for_file }
      end
    end

  end

end