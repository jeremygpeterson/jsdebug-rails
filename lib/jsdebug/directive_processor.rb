module Jsdebug
  module Rails

    class DirectiveProcessor < Sprockets::DirectiveProcessor

      def process_require_environment_directive(path, environment="production development test")
        process_require_directive(path) if environment.include? ::Rails.env
      end
    end
  end
end