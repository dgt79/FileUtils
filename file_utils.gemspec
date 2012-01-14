$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'file_utils/version'

Gem::Specification.new do |s|
	s.name        = "FileUtils"
	s.version     = Dgt::VERSION
	s.authors     = ["Dan Talpau"]
	s.email       = ["dan.talpau@gmail.com"]

	s.summary     = "FileUtils in Ruby"
	s.description = "Contains useful methods when working with files"
	s.homepage    = "http://github.com/dgt79/FileUtils"

	s.files = Dir.glob("lib/**/*.rb")
end
