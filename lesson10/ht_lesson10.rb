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
                @files << filename
            end
            @file_types.unic!
        end
        p @file_types
    end

    def get_filetypes
    end

    private

    def init_connection(params)
        @provider = params['provider']

        return nil if @provider.nil?
        case @provider
        when 'mysql'
            client = Mysql2::Client.new(host: params['host'], username: params['username'], password: params['password'])
            begin
                client.query('USE files_db')
            rescue
                client.query('CREATE DATABASE files_db')
                client.query('USE files_db')
                client.query("CREATE TABLE `filetypes` (
                                `id` int(11) NOT NULL AUTO_INCREMENT,
                                `name` char(150) NOT NULL,
                                PRIMARY KEY (`id`));")
                client.query("CREATE TABLE `files` (
                                `id` int(11) NOT NULL AUTO_INCREMENT,
                                `filetype_id` int(11) NOT NULL,
                                `name` char(100) NOT NULL,
                                PRIMARY KEY (`id`),
                                KEY `filetype_id` (`filetype_id`),
                                CONSTRAINT `filetypes_fk0` FOREIGN KEY (`filetype_id`) REFERENCES `filetypes` (`id`))")
            end
            return client
        when 'sqlite'
            return SQLite3::Database.new 'files.db'
        else
            return nil
        end
    end

    def select
    end

    def insert
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
