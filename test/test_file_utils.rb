require 'test/unit'
require File.dirname(__FILE__) + '/../lib/file_utils' # Dgt::FileUtils

class TestFileUtils < Test::Unit::TestCase
	OUTPUT = 'output'
	def setup
		FileUtils.rm_rf(OUTPUT, secure: true) if File.directory? OUTPUT
		Dir.mkdir OUTPUT
	end

	def teardown
		FileUtils.rm_rf(OUTPUT, secure: true) if File.directory? OUTPUT
	end

	def test_version_string
		assert_equal Dgt.version_string, "FileUtils version #{Dgt::VERSION}"
	end

	def test_copy_file
		file_utils = Dgt::FileUtils.new
		file_utils.copy(['test/fixtures/input.txt'], OUTPUT)

		assert File.exists?("#{OUTPUT}/input.txt")
	end

	def test_copy_file_with_new_name
		Dgt::FileUtils.new.copy ['test/fixtures/input.txt'], "#{OUTPUT}/new_name.txt"

		assert File.exists?("#{OUTPUT}/new_name.txt")
	end

	def test_copy_file_to_new_directory
		Dgt::FileUtils.new.copy ['test/fixtures/input.txt'], "#{OUTPUT}/new_dir/input.txt"

		assert File.exists?("#{OUTPUT}/new_dir/input.txt")
	end

	def test_copy_directory
		puts "pwd - #{Dir.pwd}"
		files = [] << 'test/fixtures/test_dir/a' << 'test/fixtures/test_dir/b' << 'test/fixtures/test_dir/c.txt'

		Dgt::FileUtils.new.copy files, OUTPUT

		assert File.exists?("#{OUTPUT}/a")
		assert File.exists?("#{OUTPUT}/a/a_1")
		assert File.exists?("#{OUTPUT}/a/a_1/a_1.1.txt")
		assert File.exists?("#{OUTPUT}/a/a_1/a_1.2.txt")
		assert File.exists?("#{OUTPUT}/a/a_2")
		assert File.exists?("#{OUTPUT}/b")
		assert File.exists?("#{OUTPUT}/b/b.txt")
		assert File.exists?("#{OUTPUT}/c.txt")
	end

	def test_delete_directory
		src = "#{OUTPUT}/DELETE_TEST"
		Dir.mkdir src
		Dgt::FileUtils.new.delete src
	end
end