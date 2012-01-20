require "fileutils"

module Dgt
	module FileUtilsDelete
		def delete(path)
			trash = "#{ENV['HOME']}/.Trash"
			::FileUtils.mv path, trash, force: true
		end
	end
end
