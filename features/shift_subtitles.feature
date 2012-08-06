Feature: AV editor shifts subtitles

  In order to keep AV in sync
  As an AV editor
  I want to shift subtitle timings
  
  
  Scenario: AV editor adds 2 seconds a 1 subtitle
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 01:31:51,210 --> 01:31:54,893 | Fuck me, hold tight. What's that? |        
    When I successfully run `shift_subtitles --action add --time 02,000 --input input.srt --output output_add_2s.srt`
    Then the output should contain "Shift Subtitle successfully run. Welcome to AV heaven"
    And a file named "output_add_2s.srt" should exist
    And "output_add_2s.srt" should contain the following
      | index | duration                      | text                              |
      | 645   | 01:31:53,210 --> 01:31:56,893 | Fuck me, hold tight. What's that? |
  
  
  Scenario: AV editor subtracts 1.5 seconds from 1 subtitle
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 01:31:51,210 --> 01:31:54,893 | Fuck me, hold tight. What's that? |                
    When I successfully run `shift_subtitles --action subtract --time 01,500 --input input.srt --output output_subtract_1.5s.srt`
    Then the output should contain "Shift Subtitle successfully run. Welcome to AV heaven"
    And a file named "output_subtract_1.5s.srt" should exist
    And "output_subtract_1.5s.srt" should contain the following
      | index | duration                      | text                              |
      | 645   | 01:31:49,710 --> 01:31:53,393 | Fuck me, hold tight. What's that? | 
  
  
  Scenario: AV editor adds 2 seconds 3 subtitles
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 01:31:51,210 --> 01:31:54,893 | Fuck me, hold tight. What's that? |  
      | 646   | 01:31:56,500 --> 01:31:57,220 | It's me belt, Turkish.            |
      | 647   | 01:31:59,800 --> 01:32:03,520 | No, Tommy. There's a gun in your trousers. What's a gun doing in your trousers? |
    When I successfully run `shift_subtitles --action add --time 02,000 --input input.srt --output output_add_2s_3subs.srt`
    Then the output should contain "Shift Subtitle successfully run. Welcome to AV heaven"
    And a file named "output_add_2s_3subs.srt" should exist
    And "output_add_2s_3subs.srt" should contain the following
      | index | duration                      | text                              |
      | 645   | 01:31:53,210 --> 01:31:56,893 | Fuck me, hold tight. What's that? |
      | 646   | 01:31:58,500 --> 01:31:59,220 | It's me belt, Turkish.            | 
      | 647   | 01:32:01,800 --> 01:32:05,520 | No, Tommy. There's a gun in your trousers. What's a gun doing in your trousers? |
      
  
  Scenario: AV editor doesn't specify an input file    
    When I run `shift_subtitles --action add --time 02,000 --output output_add_2s_3subs.srt`
    Then the output should contain "OOPS! something went wrong......Please specify an input file"
    
  
  Scenario: AV editor specifies an invalid input file    
    When I run `shift_subtitles --action add --time 02,000 --input nan --output output_add_2s_3subs.srt`
    Then the output should contain "OOPS! something went wrong......Please specify a valid input file"
    

  Scenario: AV editor doesn't specify an output file    
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 01:31:51,210 --> 01:31:54,893 | Fuck me, hold tight. What's that? |
    When I run `shift_subtitles --action add --time 02,000 --input input.srt`
    Then the output should contain "OOPS! something went wrong......Please specify an output file"
  

  Scenario: AV editor doesn't specify a time    
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 01:31:51,210 --> 01:31:54,893 | Fuck me, hold tight. What's that? |
    When I run `shift_subtitles --action add --input input.srt --output output.srt`
    Then the output should contain "OOPS! something went wrong......Please specify a time to shift"
    

  Scenario: AV editor doesn't specify a valid time    
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 01:31:51,210 --> 01:31:54,893 | Fuck me, hold tight. What's that? |
    When I run `shift_subtitles --action add --time 999 --input input.srt --output output.srt`
    Then the output should contain "OOPS! something went wrong......Please specify a valid time to shift"    
    
  Scenario: AV editor specifies a time that would push the output into negatives    
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 00:00:01,210 --> 00:00:01,893 | Fuck me, hold tight. What's that? |
    When I run `shift_subtitles --action subtract --time 03,000 --input input.srt --output output.srt`
    Then the output should contain "OOPS! something went wrong......Please specify a legal time to shift, this will push the subs into negative values"    
    
  Scenario: AV editor specifies an invalid operation
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 00:00:01,210 --> 00:00:01,893 | Fuck me, hold tight. What's that? |
    When I run `shift_subtitles --action sutt --time 01,000 --input input.srt --output output.srt`
    Then the output should contain "OOPS! something went wrong......Please specify either 'add' or 'subtract' as the operation"
  
  Scenario: AV editor has an invalid duration in the input    
    Given "input.srt" contains the following
      | index | duration                      | text                              |
      | 645   | 01:031:51,210 --> 01:31:54,893| Fuck me, hold tight. What's that? | 
      | 646   | 01:31:58,500 --> 01:31:59,220 | It's me belt, Turkish.            |
    When I run `shift_subtitles --action add --time 02,000 --input input.srt --output output.srt`
    Then the output should contain "Shift Subtitle successfully run. Welcome to AV heaven"
    And a file named "output.srt" should exist
    And "output.srt" should contain the following
      | index | duration                      | text                              |
      | 646   | 01:32:00,500 --> 01:32:01,220 | It's me belt, Turkish.            |     
  
  
  
  
  
  
  
  
    