require 'mysql2'
require 'sqlite_magic'


def DataBase(type, params = {})
    Object.const_get("DataBase::#{type.capitalize}").new params
  rescue NameError
    raise 'Неизвестный тип БД'
end

class QueryBuilder
    attr_reader :result, :query
    attr_accessor :db

    def initialize db
      @db= db
    end

    def set_scheme(scheme)
        @scheme = scheme
        # TODO: init from yaml file
    end

    def set_query(query)
        @query = query
        self
    end

    def run
        @result = db.execute @query
        @query = ''
        self
    end

    def create_database(name)
        @query = "CREATE DATABASE IF NOT EXISTS #{name} CHARSET utf8"
    end

    def show
        @result.each do |row|
            puts row
        end
    end

    def from(table)
        @query += " FROM
                 #{table}"
        self
    end

    def where(condition)
        @query += " WHERE
                 #{condition}"
        self
    end

    def select(fields = '*')
        @query = "SELECT #{fields} "
        self
    end

    def insert(table, values = {})
        @query = "INSERT INTO `#{table}` (`#{values.keys.join('`, `')}`)
                  VALUES ('" + values.values.join("', '") + "');"
        run
    end
    def update(table, id, values)
        @query = "UPDATE `#{table}` SET"
    end
end

class DataBase
    attr_accessor :query_builder

    def initialize(params = {})
        @params = params
        @query_builder = QueryBuilder.new self
    end

    class Mysql < self
        def init_connection
            @connection = Mysql2::Client.new(host:     @params['host'],
                                             username: @params['username'],
                                             password: @params['password'])
            @connection.query "USE #{@params['dbname']}"
        end

        def execute(query)
            @connection.query query
        end

        def list_tables
          tables = []
          @query_builder.set_query('SHOW TABLES').run.result.each do |table|
            tables += table.values
          end
          tables
        end
        def list_fields table
          fields = []
          @query_builder.set_query("SHOW COLUMNS FROM #{table}").run.result.each do |row|
            fields << row['Field']
          end
          fields
        end

    end
    class Sqlite < self
        def init_connection(_params)
            @connection = SqliteMagic::Connection.new "#{@params['dbname']}.db"
        end

        def execute(query)
            @connection.execute query
        end
    end
    class Pg < self; end
end
