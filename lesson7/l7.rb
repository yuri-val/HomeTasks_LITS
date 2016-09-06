class ParamValidator
	def name;  return @name;  end
	def phone; return @phone; end
	def email; return @email; end
	
	def initialize params
		params_hash = parse_params params
		#puts parse_params params
		@name = params_hash["name"]
		@phone = params_hash["phone"]
		@email = params_hash["email"]
		
	end
	
	def valid?
		return true
	end
	
	private
	def parse_params params
		est_params = ['name', 'phone', 'email']
		unless params.size == 3 
			puts "i wanna 3 parameters: #{est_params}"
			exit(1)
		end
		hash = Hash.new
		params.each do |param|
			kv_param = param.split("=")
			hash[kv_param[0]] = kv_param[1]
		end
		est_params.each do |param_name|
			if hash[param_name].nil?  
				puts "can\'t find parameter \"#{param_name}\". estimated parameters: #{est_params}" 
				exit(1)
			end	
		end
		return hash	
	end
end

class Replacer

	def initialize path
		i_file = File.open path, 'r' 
		@data_from_file = i_file.read
		i_file.close
	end
	
	def replace params
		o_path = 'lesson7.html'
		o_file = File.open o_path, 'w'
		name_patern  = '/<h1 class="well" id="name">(.*)<\/h1>/'
		email_patern = '/<span class="badge" id="email">(.*)<\/span>/'
		phone_patern = '/<span class="badge" id="phone">(.*)<\/span>/'
		
		@data_from_file.sub! '/<h1 class="well" id="name">(.*)<\/h1>/',  params.name
		@data_from_file.sub! email_patern, params.email
		@data_from_file.sub! phone_patern, params.phone
		
		
		o_file.write @data_from_file
		o_file.close
		
				
	end

end

path_to_html = '../lesson4/index.html'

params = ParamValidator.new ARGV
if params.valid?
	repl = Replacer.new path_to_html
	repl.replace params
end 

#puts params.name, params.phone, params.email 
