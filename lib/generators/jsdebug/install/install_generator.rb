module Jsdebug
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def generate_install
        copy_file "jsdebug.js", "app/assets/javascripts/jsdebug.js"
      end

      def inject_jsdebug
        inject_into_file "app/assets/javascripts/application.js", :before => "//= require_tree" do
          "//= require_environment 'jsdebug' 'development'\n"
        end
      end

    end
  end
end
