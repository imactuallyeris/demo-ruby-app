require 'rspec/core/rake_task'

task default: :spec

desc "Run the test suite"
RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = "spec/**/*_spec.rb"
  task.verbose = true
end

desc "Display RSpec version"
task :version do
  puts RSpec::Version::STRING
end

