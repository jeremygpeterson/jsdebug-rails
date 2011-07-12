require 'bundler'
Bundler::GemHelper.install_tasks

require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.warning = false
end