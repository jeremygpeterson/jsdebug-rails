# -*- encoding: utf-8 -*-
require File.expand_path("../lib/jsdebug/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "jsdebug-rails"
  s.version     = Jsdebug::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Peterson"]
  s.email       = ["jeremy.g.peterson@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/jsdebug-rails"
  s.summary     = "Provides javascript logging for development and removes statements when in production."
  s.description = "Jsdebug extends the asset pipeline for javascript logging."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "jsdebug-rails"

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "thor",  "~> 0.14"

  s.add_development_dependency "mocha", "= 0.9.8"
  s.add_development_dependency "bundler", ">= 1.0.0.rc.6"

  #s.files = Dir["lib/**/*"]
  s.files = %w[lib/generators/jsdebug/install/install_generator.rb
               lib/jsdebug/directive_processor.rb
               lib/jsdebug/processor.rb
               lib/jsdebug/railtie.rb
               lib/jsdebug/version.rb
               lib/jsdebug-rails.rb
               lib/generators/jsdebug/install/templates/jsdebug.js
               README.md]

  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
