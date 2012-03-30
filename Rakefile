require 'bundler'
Bundler::GemHelper.install_tasks

require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = Dir.glob("test/**/test_*.rb")
  t.libs << "test"
  t.warning = false
end