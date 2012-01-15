$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'file_utils/version'

Gem::Specification.new do |s|
	s.name        = "dgt_file_utils"
	s.version     = Dgt::VERSION
	s.authors     = ["Dan Talpau"]
	s.email       = ["dan.talpau@gmail.com"]

	s.summary     = "extra methods for working with files"
	s.description = "Contains useful methods when working with files"
	s.homepage    = "http://github.com/dgt79/FileUtils"

	s.files = Dir.glob("lib/**/*.rb")
	s.test_files  = Dir.glob("test/**/*.rb")
end
