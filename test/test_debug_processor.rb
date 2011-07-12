require "test_helper"
require "test/unit"

class JsdebugProcessorTest < Sprockets::TestCase
  def setup
    @logger = Object.new
    Rails.stubs(:logger).returns(@logger)

    @env = Sprockets::Environment.new
    @env.append_path fixture_path('assets')
    @env.register_processor 'application/javascript', Jsdebug::Rails::Processor
  end

  test "javascript compiles without debug statements" do
    @logger.stubs(:level).returns(1)
    assert_equal "var foo = {},\nbar = {};\n", @env['application.js'].to_s
  end

  test "javascript compiles with debug statements" do
    @logger.stubs(:level).returns(0)
    assert_equal "var foo = {},\nbar = {};\ndebug.log('[application::3]', foo);\n", @env['application.js'].to_s
  end
  
  test "javascript compiles without multiple debug statements" do
    @logger.stubs(:level).returns(1)
    assert_equal "var bar = true;\nbar = false;\n", @env['multiple_debugs.js'].to_s
  end

  test "javascript compiles with multiple debug statements" do
    @logger.stubs(:level).returns(0)
    assert_equal "var bar = true;\ndebug.log('[multiple_debugs::2]', bar);\nbar = false;\ndebug.log('[multiple_debugs::4]', bar);\n", @env['multiple_debugs.js'].to_s
  end

  test "javascript compiles without debug block statements" do
    @logger.stubs(:level).returns(1)
    assert_equal "var str = \"Hello\";\nvar str2 = \"Bye\";\n", @env['block_debugs.js'].to_s
  end

  test "javascript compiles with debug block statements" do
    @logger.stubs(:level).returns(0)
    assert_equal "var str = \"Hello\";\n// debug_start\nstr = str + \" World!\";\ndebug.log('[block_debugs::4]', str);\n// debug_end\nvar str2 = \"Bye\";\n", @env['block_debugs.js'].to_s
  end

end