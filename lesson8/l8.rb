class GeometricShape
	@@perimeter = 0
	@@square = 0
end

class Circle < GeometricShape
	def set_prop args = {}
		@@radius = 0
	end

	def square
			Math.PI * @@radius ** 2
	end
end

class Rectangle < GeometricShape
	def set_prop args = {}
		prop = args.prop.split ','
		@@side_a = 0
		@@side_b = 0
	end
	def square
		@@side_a * @@side_b
	end
end

class Triangle < GeometricShape
	def set_prop args = {}
		@@side_a = 0
		@@side_b = 0
		@@side_c = 0
	end
	private
	def perimeter side_a, side_b, side_c

	end
	def square side_a, side_b, side_c

	end
end

class SqureCalculator
	@file_struct
	def initialize parser
		@file_struct = parser.file_struct
	end
	def calculate
		@file_struct.each do |item|
			puts item.inspect
		end
	end

end

class FileParser
	@file_path
	def initialize path_to_file
		@file_path = path_to_file
	end

	def file_struct; return @file_struct; end

	def parse_file log
		@file_struct = []
		lines = IO.readlines @file_path
		lines.each_index do |i|
			parameters = lines[i].split ':'
			unless parameters.size == 2
					log.add_to_log "wrong data at string ##{i + 1}"
			end
			@file_struct << {"line"=> i + 1, "shape"=> parameters[0], "prop"=> parameters[1].chomp!}
		end
		@file_struct.sort_by! do |item|
			item["shape"]
		end
	end

end

class ErrorLog < File
	@log_file
	def initialize path_to_log
		@log_file = open path_to_log, 'a'
	end

	def add_to_log msg
		@log_file << msg
	end

	def close_log
		@log_file.close
	end

end

log = ErrorLog.new "errors.log"
path_to_file = ARGV[0]
parser = FileParser.new path_to_file
parser.parse_file log
calculator = SqureCalculator.new parser
calculator.calculate
log.close_log
