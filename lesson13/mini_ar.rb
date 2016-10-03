require './db'

class MiniActiveRecord
  # сохраним список сгенерированных классов в переменной класса
  class << self; attr_reader :generated_classes; end
  @generated_classes = []

  def initialize(attributes = nil)
    if attributes
      attributes.each_pair do |key, value|
        instance_variable_set('@' + key, value)
      end
    end
  end

  def self.connect(params)
    @@db = DataBase params['provider'], params
    @@db.init_connection

    # пройдёмся по списку таблиц и создадим классы для них
    @@db.list_tables.each do |table_name|
      class_name = table_name.split('_').collect { |word| word.capitalize }.join
      class_name.slice!(class_name.size - 1)
      # создаём класс для таблицы, используя Module#const_set
      classFile = File.new("models/#{table_name}.rb", "w" )
      classFile.puts "require './mini_ar'"
      classFile.puts "class #{class_name} < MiniActiveRecord"
      classFile.puts "  @@table_name = '#{table_name}'\n"\
                     "\n"\
                     "  def fields; @@fields; end\n"\
      # пройдёмся по списку полей таблицы и создадим методы getter и setter для них
      attribs = ""
      @@db.list_fields(table_name).each do |field|
        # добавляем getter и setter
        #klass.send :attr_accessor, field
        attribs += ":#{field}, "
        # добавляем имя поля в список полей
        #klass.module_eval { @@fields << field }
      end
      attribs.slice!(attribs.size - 2)
      classFile.puts "  attr_accessor #{attribs}\n"\
                     "  @@fields = #{@@db.list_fields(table_name)}\n"\
                     "end"
      #p klass.new.fields
      @generated_classes << class_name
      #p klass.new.fields
      classFile.close
    end
  end

  def self.all_tables
      @@db.list_tables
  end
  # получаем все строки
  def self.all
      result = @@db.query_builder.select(" * ").from(@@table_name).run.result
      found = []
      result.each do |attributes|
        found << new(attributes)
      end
      found
    end
  # получаем строку таблицы по идентификатору
  def self.get(id)
    result = @@db.query_builder.select(" * ").from(@@table_name).where(" id = #{id}").run.result
    attributes = result.first
    new(attributes) if attributes
  end

  def self.get_by(key, value)
    result = @@db.query_builder.select(" * ").from(@@table_name).where(" #{key} = #{value}").run.result
    found = []
    result.each do |attributes|
      found << new(attributes)
    end
    found
  end

end
