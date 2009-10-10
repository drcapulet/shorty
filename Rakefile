

# begin
#   require 'cucumber/rake/task'
# 
#   Cucumber::Rake::Task.new(:features) do |t|
#     t.fork = true
#     t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'pretty')]
#   end
# rescue LoadError
#   desc 'Cucumber rake task not available'
#   task :features do
#     abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
#   end
# end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "shorty"
    gemspec.summary = "Gem that talks to APIs for shortening urls"
    gemspec.description = "Makes it easy to shorten URLs"
    gemspec.email = "alex@alexcoomans.com"
    gemspec.homepage = "http://github.com/drcapulet/shorty"
    gemspec.authors = ["Alex Coomans"]
    gemspec.add_dependency('httparty', '>= 0.4.4')
    gemspec.add_dependency('crack', '>= 0.1.4')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'doc'
  rdoc.title = "shorty #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end