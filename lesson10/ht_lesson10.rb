require 'json'
require 'mysql2'
require 'sqlite3'
require 'mimemagic'

class Connector
    def initialize(params = {})
        @params = params
        @connection = init_connection params
        if @connection.nil?
            puts "can\'t esteblish connection"
            exit 1
        end
    end

    def scan_path
        @files = []
        @file_types = []
        Dir.foreach(@params['path']) do |filename|
            mime_type = MimeMagic.by_path(filename)
            unless mime_type.nil?
                @file_types << mime_type.type
                @files << {"name" => filename, "filetype" => mime_type.type}
            end
            @file_types.unic!
        end
		exist_filetypes = []
		maped_types = {}
        get_filetypes.each do |h_type|
			exist_filetypes << h_type['name']
		end
		to_add = @file_types - exist_filetypes
		insert "name", "filetypes", to_add 
		
		get_filetypes.each do |h_type|
			maped_types[h_type['name']] = h_type['id']
		end
		
		values = []
		@files.each do |h_file|
			values << "#{maped_types[h_file['filetype']]}, #{h_file['name']}"
		end
		insert "filetype_id, name", "files", values
		
    end

    def get_filetypes
		select "id, name", "filetypes"
    end

	def show_filetypes
	
	end
	
	def show_files
	
	end
	
	def show_data
	
	end
	
    private

    def init_connection(params)
        @provider = params['provider']

        return nil if @provider.nil?
        case @provider
        when 'mysql'
            client = Mysql2::Client.new(host: params['host'], username: params['username'], password: params['password'])
			client.query('CREATE DATABASE IF NOT EXIST files_db')
			client.query('USE files_db')
            client.query("CREATE TABLE IF NOT EXIST `filetypes` (
							`id` int(11) NOT NULL AUTO_INCREMENT,
							`name` char(150) NOT NULL,
							PRIMARY KEY (`id`));")
            client.query("CREATE TABLE IF NOT EXIST `files` (
							`id` int(11) NOT NULL AUTO_INCREMENT,
							`filetype_id` int(11) NOT NULL,
							`name` char(100) NOT NULL,
							PRIMARY KEY (`id`),
							KEY `filetype_id` (`filetype_id`),
							CONSTRAINT `filetypes_fk0` FOREIGN KEY (`filetype_id`) REFERENCES `filetypes` (`id`))")
            return client
        when 'sqlite'
            client = SQLite3::Database.new 'files.db'
			client.execute("CREATE TABLE IF NOT EXISTS `filetypes` (
							`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
							`name` char(150) NOT NULL);")
			client.execute("CREATE TABLE IF NOT EXISTS files(
							id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
							filetype_id INT(11), 
							name VARCHAR(150), 
							FOREIGN KEY (`filetype_id`) REFERENCES `filetypes` (`id`))")
			return client
        else
            return nil
        end
    end
	
	def execute_query(query)
		case @provider
        when 'mysql'
			result = @connection.query query
		when 'sqlite'
			result = @connection.execute query
		else 
			result = nil
		end
		return result 
	end

    def select(fields = "*", table)
		query = "SELECT #{fields} FROM #{table}"
		return execute_query query
	end

    def insert(fields = "", table, values = [])
		string_values = "(#{values * "), ("})"
		query = "INSERT INTO #{table} (#{fields}) VALUES #{string_values}"
		return execute_query query
    end

    def update
    end

    def delete
    end
end

configs = JSON.parse File.open('config.json', &:read)
p configs

connector = Connector.new configs
connector.scan_path
