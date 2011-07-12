require "test_helper"
require "test/unit"

class DirectiveProcessorTest < Sprockets::TestCase
  def setup
    @env = Sprockets::Environment.new
    @env.append_path fixture_path('context')
    @env.unregister_processor 'application/javascript', Sprockets::DirectiveProcessor
    @env.register_processor 'application/javascript', Jsdebug::Rails::DirectiveProcessor
  end

  test "directive processor in development environment" do
    Rails.stubs(:env).returns("development")

    assert_equal "var foo = {};\nwindow.debug = {};\n", @env['application.js'].to_s
  end

  test "directive processor in production environment" do
    Rails.stubs(:env).returns("production")

    assert_equal "var foo = {};\n", @env['application.js'].to_s
  end

end