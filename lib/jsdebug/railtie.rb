require "rails"
module Jsdebug
  module Rails
    class Railtie < ::Rails::Railtie
      config.after_initialize do |app|
        app.assets.unregister_preprocessor 'application/javascript', Sprockets::DirectiveProcessor

        app.assets.register_preprocessor 'application/javascript', Jsdebug::Rails::DirectiveProcessor
        app.assets.register_preprocessor 'application/javascript', Jsdebug::Rails::Processor
      end
    end
  end
end
