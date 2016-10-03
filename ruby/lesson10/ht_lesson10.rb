require 'json'
require 'mysql2'
require 'sqlite_magic'
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
                @file_types << "'#{mime_type.type.to_s}'"
                @files << { 'name' => filename, 'filetype' => mime_type.type.to_s }
            end
            @file_types.uniq!
        end
        exist_filetypes = ['']
        maped_types = {}
        get_filetypes.each do |h_type|
            exist_filetypes << "'#{h_type['name'].to_s}'"
        end
        to_add = @file_types - exist_filetypes
        insert 'name', 'filetypes', to_add if to_add.size > 0

        get_filetypes.each do |h_type|
            maped_types[h_type['name']] = h_type['id']
        end

        values = []
        @files.each do |h_file|
            values << "#{maped_types[h_file['filetype']]}, '#{h_file['name']}'"
        end
        insert 'filetype_id, name', 'files', values
    end

    def get_filetypes
        select 'id, name', 'filetypes'
    end

    def show_result result
      result.each do |row|
        p row
      end
    end

    def show_filetypes
        result = select '*', 'filetypes'
        show_result result
    end

    def show_files
        result = select '*', 'files'
        show_result result
    end

    def show_data
        result = execute_query "SELECT
                          files.name, filetypes.name AS filetype
                          FROM files
                          LEFT JOIN filetypes ON files.filetype_id = filetypes.id"
        show_result result
    end

    private

    def init_connection(params)
        @provider = params['provider']

        return nil if @provider.nil?
        case @provider
        when 'mysql'
            client = Mysql2::Client.new(host: params['host'], username: params['username'], password: params['password'])
            client.query('CREATE DATABASE IF NOT EXISTS files_db CHARSET utf8')
            client.query('USE files_db')
            client.query("CREATE TABLE IF NOT EXISTS `filetypes` (
							`id` int(11) NOT NULL AUTO_INCREMENT,
							`name` char(150) NOT NULL,
							PRIMARY KEY (`id`));")
            client.query("CREATE TABLE IF NOT EXISTS `files` (
							`id` int(11) NOT NULL AUTO_INCREMENT,
							`filetype_id` int(11) NOT NULL,
							`name` char(100) NOT NULL,
							PRIMARY KEY (`id`),
							KEY `filetype_id` (`filetype_id`),
							CONSTRAINT `filetypes_fk0` FOREIGN KEY (`filetype_id`) REFERENCES `filetypes` (`id`))")
            return client
        when 'sqlite'
            client = SqliteMagic::Connection.new 'files.db'
            client.execute("CREATE TABLE IF NOT EXISTS `filetypes` (
      							`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
      							`name` char(150) NOT NULL);")
            client.execute("CREATE TABLE IF NOT EXISTS files(
      							`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      							`filetype_id` INT(11),
      							`name` VARCHAR(150),
      							FOREIGN KEY (`filetype_id`) REFERENCES `filetypes` (`id`))")
            return client
        else
            return nil
        end
    end

    def execute_query(query)
        result = case @provider
                 when 'mysql'
                     @connection.query query
                 when 'sqlite'
                     @connection.execute query
        end
        result
    end

    def select(fields = '*', table)
        query = "SELECT #{fields} FROM #{table}"
        result = execute_query query
  end

    def insert(fields = '', table, values)
        string_values = "( #{values * '), ('})"
        query = "INSERT INTO #{table} (#{fields}) VALUES #{string_values}"
        execute_query query
    end

    def update
    end

    def delete
    end
end

configs = JSON.parse File.open('config.json', &:read)

connector = Connector.new configs
connector.scan_path
connector.show_data
