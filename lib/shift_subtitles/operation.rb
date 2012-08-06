module ShiftSubtitles

  class Operation

    attr_reader :action, :time

    def initialize options
      @action = action_with_validation(options[:action])
      @time = time_with_validation(options[:time])
    end

    def seconds_difference
      case action
      when "add" then return time_difference
      when "subtract" then return negative_time_difference
      end
    end
    
    def action_with_validation action 
      valid_action?(action) ? action : raise("Please specify either 'add' or 'subtract' as the operation")
    end

    def time_with_validation time
      raise("Please specify a time to shift") unless time
      raise("Please specify a valid time to shift") unless valid_time?(time)
      time      
    end

    def valid_time? time
      time =~ /\A[0-9]{2},[0-9]{3}\Z/
    end
    
    def valid_action? action
      action =~ /\A(add|subtract)\Z/
    end

    def time_difference
      time.sub(',','.').to_f
    end
    
    def negative_time_difference
      -time_difference
    end

  end

end