require 'file_utils/version'
require 'file_utils_delete'
require 'file_utils_copy'
require 'logger'


module Dgt
	$LOG = Logger.new(STDOUT)

	def self.version_string
		"FileUtils version #{Dgt::VERSION}"
	end

	class FileUtils
		include Dgt::FileUtilsDelete
		include Dgt::FileUtilsCopy

	end


end
