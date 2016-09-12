class GeometricShape
	@@perimeter
	@@square
end

class Circle < GeometricShape
	@@radius
	def initialize args = {}

	end
	private
	def perimeter radius

	end
	def square radius

	end
end

class Rectangle < GeometricShape
	@@side_a
	@@side_b
	def initialize args = {}

	end
	private
	def perimeter side_a, side_b

	end
	def square side_a, side_b

	end
end

class Triangle < GeometricShape
	@@side_a
	@@side_b
	@@side_c
	def initialize = {}

	end
	private
	def perimeter side_a, side_b, side_c

	end
	def square side_a, side_b, side_c

	end
end

class FileParser < IO
	@file_path
	@file_struct = []
	def initialize path_to_file
		@file_path = path_to_file
	end

	def parse_file
		lines = readlines(file_path)
		lines.each_index do |i|
			parameters = lines[i].split ':'

			@file_struct << {}
		end
	end

end

class ErrorLog < File
	@log_file
	def initialize path_to_log
		@log_file = open path_to_file, 'a'
	end

	def add_to_log msg
		@log_file << msg
	end

	def close_log
		@log_file.close
	end

end
