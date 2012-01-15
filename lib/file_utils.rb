require 'file_utils/version'
require 'logger'
require 'pathname'

$LOG = Logger.new(STDOUT)

module Dgt
	def self.version_string
		"FileUtils version #{Dgt::VERSION}"
	end

	class FileUtils
		# Copies files to destination.
		# If files array contains a single file, then destination can be a new file name, e.g. copy ['input.txt'], 'input_new_name.txt'
		# If files contains multiple files, then destination has to be a directory; if destination directory does not exist, then
		# it will be created.
		# If files contains directories, then they will be copied recursively
		#
		# Params:
		# files 												- file path array; can contain both files and directories
		# destination										-	destination path
		# block(file, progress)					- call block with two arguments: the file path of the file being copied and progress percentage
		def copy(files, destination, &callback)
			#FileUtils.cp_r file.path, destination, verbose: true
			if File.directory? destination
				files.each do |file|
					if File.directory? file
						low_level_copy(file, destination, &callback)
					else
						dest_file = '' << destination << '/' << File.basename(file)
						low_level_copy file, dest_file, &callback
					end
				end
			else
				if files.size == 1
					destination_path = File.dirname destination
					if !File.directory? destination_path
						$LOG.debug "mkdir_p #{destination_path}"
						::FileUtils.mkdir_p destination_path
					end
					low_level_copy(files[0], destination, &callback)
				else
					$LOG.debug "mkdir_p #{destination}"
					::FileUtils.mkdir_p destination
					files.each {|file| low_level_copy(file, destination + '/' + file.name, &callback)}
				end
			end
		end

		def low_level_copy(src, dest, &block)
			$LOG.debug "copy #{src} to #{dest}"
			if File.directory? src
				copy_dir(src, dest, &block)
			else
				copy_file(dest, src)
			end
		end

		def copy_dir(src, dest, &block)
			dir = '' << dest << '/' << File.basename(src)
			$LOG.debug "mkdir #{dir}"
			Dir.mkdir dir
			Pathname(src).each_child do |file|
				if File.directory? file
					low_level_copy file, dir, &block
				else
					dest_file = '' << dir << '/' << File.basename(file)
					low_level_copy file, dest_file, &block
				end
			end
		end

		def copy_file(dest, src)
			in_file = File.new(src, "r")
			out_file = File.new(dest, "w")
			in_size = File.size(src)
			buffer_size = in_size < 1024 * 16 ? in_size : 1024 * 16
			total = 0
			buffer = in_file.sysread(buffer_size)
			while total < in_size do
				out_file.syswrite(buffer)
				total += buffer_size
				progress = (total * 100 / in_size).to_s + '%'
				yield(src, progress) if block_given?
				buffer_size = in_size - total if (in_size - total) < buffer_size
				buffer = in_file.sysread(buffer_size)
			end
			in_file.close
			out_file.close
		end
	end


end
