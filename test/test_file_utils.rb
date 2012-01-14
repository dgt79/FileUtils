require 'test/unit'
require 'file_utils'

class TestFileUtils < Test::Unit::TestCase
	def test_version_string
		assert_equal Dgt.version_string, "FileUtils version #{Dgt::VERSION}"
	end
end