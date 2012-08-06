Gem::Specification.new do |spec|
  spec.name = 'shift_subtitles'
  spec.version = '0.1.1'
  spec.authors = ['James Shipton']
  spec.email = ['ionysis@gmail.com']
  spec.homepage = 'https://github.com/jamesshipton/quizzes/tree/master/shift_subtitles'
  spec.summary = 'Shift Subtitles - Ruby Learning Challenge #1'
  spec.description = 'Shift Subtitles - Ruby Learning Challenge #1'
     
  spec.add_development_dependency 'rspec', '~> 2.6'
  spec.add_development_dependency 'cucumber', '~> 1.1.0'
  spec.add_development_dependency 'aruba', '~> 0.4.6'
 
  spec.files = Dir.glob('lib/**/*')
  spec.test_files = Dir.glob('spec/**/*')
  spec.require_path = 'lib'
  spec.bindir = 'bin'
  spec.executables = ["shift_subtitles"]
end