# -*- encoding: utf-8 -*-
require File.expand_path("../lib/jsdebug/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "jsdebug-rails"
  s.version     = Jsdebug::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Peterson"]
  s.email       = ["jeremy.g.peterson@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/jsdebug-rails"
  s.summary     = "Provides javascript loging for development and removes statements when in production."
  s.description = "Jsdebug extends the asset pipeline for javascript logging."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "jsdebug-rails"

  s.add_dependency "tilt", ["~> 1.1", "!= 1.3.0"]
  s.add_dependency "sprockets", "~>2.0.0"
  s.add_dependency "thor",     "~> 0.14"

  s.add_development_dependency "mocha", "= 0.9.8"
  s.add_development_dependency "bundler", ">= 1.0.0.rc.6"

  s.files = Dir["lib/**/*"]
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
