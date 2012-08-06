module ShiftSubtitles

  module FileHelper

    def self.operation_with_validation operation, file_name
      raise("Please specify an #{operation} file") unless file_name
      if operation == 'input'
        raise("Please specify a valid #{operation} file") unless File.exists?(file_name)
      end
      yield      
    end


  end

end