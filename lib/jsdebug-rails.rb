
module Jsdebug
  module Rails
    require 'jsdebug/directive_processor'
    require 'jsdebug/processor'
    require 'jsdebug/railtie'
    require "jsdebug/version"
  end
end

# TODO: Remove in 1.0.0 Version
if defined?(Rails::VERSION::STRING) && Rails::VERSION::STRING.match(/^3\.1\.0\.beta/)
  message = "WARNING: Jsdebug-rails #{Jsdebug::Rails::VERSION} is incompatible with Rails #{Rails::VERSION::STRING}. Please upgrade to Rails 3.1.0.rc1 or higher."
  if defined?(Rails.logger) && Rails.logger
    Rails.logger.warn(message)
  else
    warn(message)
  end
end