def format_file_contents file_contents
  file_contents.hashes.collect { |content| "#{content['index']}\n#{content['duration']}\n#{content['text']}\n\n" }.join
end