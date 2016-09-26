require 'yaml'
# Ruby-метод для создания объекта нужного класса
def self.Figure(type, params = {})
    Object.const_get("Figure::#{type.capitalize}").new params
  rescue NameError
    raise 'Неизвестный тип фигуры'
end

def self.DataBase(type, params = {})
    p type
    Object.const_get("DataBase::#{type.capitalize}").new params
  rescue NameError
    raise 'Неизвестный тип БД'
end

class SqlQueryCreator

    attr_reader :result

    def set_scheme scheme
      @scheme = scheme
    end

    def run
      @result = self.execute
      @query = ""
    end

    def create_database name
      @query = "CREATE DATABASE IF NOT EXISTS #{name} CHARSET utf8"
    end

    def show
      @result.each do |row|
        puts row
      end
    end

    def from table
      @query += " FROM
               #{table}"
      self
    end

    def where condition
       @query += " WHERE
                #{condition}"
       self
    end

    def select fields='*'
      @query= "SELECT #{fields} "
      self
    end

    def insert table, values= {}
      @query= "INSERT INTO `#{table}` (`#{values.keys.join('`, `')}`) VALUES ('"+values.values.join("', '")+"');"
      run
    end

end

class Figure
    include Math
    attr_reader :p1, :p2, :p3, :p4, :p5, :formula, :squre

    def initialize params
        set_params params
    end
    def set_params params
      @p1 = params['p1']
      @p2 = params['p2']
      @p3 = params['p3']
      @p4 = params['p4']
      @p5 = params['p5']
      @formula = params['formula']
      @squre = 0
      p params
    end

    def calc_squre
      to_eval = "@squre = #{@formula}"
      eval to_eval
      p @squre
    end

    class Circle < self; end
    class Rectangle < self; end
    class Romb < self; end
    class Triangle < self; end
end

class DataBase < SqlQueryCreator
  def initialize(params = {})
      @params = params
  end

  class Mysql < self
    def init_connection
      @connection = Mysql2::Client.new(host:     @params['host'],
                                       username: @params['username'],
                                       password: @params['password'])
    end
    def init_db; end
    def execute query
      @connection.query query
    end
  end
  class Sqlite < self
    def init_connection(params)
        @connection = SqliteMagic::Connection.new "#{@params['dbname']}.db"
    end
    def init_db; end
    def execute query
       @connection.execute query
    end
  end
  class Pg < self; end

end

class FileParser
	def initialize path_to_file
		@file_path = path_to_file
	end

	def file_struct; return @file_struct; end

	def parse_file
		@file_struct = []
		lines = IO.readlines @file_path
		lines.each_index do |i|
			parameters = lines[i].split ':'
			unless parameters.size == 2
					next
			end
			@file_struct << {"line"=> i + 1, "shape"=> parameters[0], "prop"=> parameters[1].chomp!}
		end
		@file_struct.sort_by! do |item|
			item["shape"]
		end
	end

end

config = YAML.load_file("config.yml")

db = DataBase config['provider'], config

db.sth

fig = Figure :triangle, {'p1' => 2, 'formula' => 'sin(p1 * 2 + 4)'}
p fig
fig.calc_squre


# res = YAML.load_file("db.yml")
# p res
