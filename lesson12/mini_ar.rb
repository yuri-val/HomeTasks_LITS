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
      klass = ''
      klass = Object.const_set(class_name, Class.new(MiniActiveRecord))
      klass.module_eval do
        @@fields = []
        @@table_name = table_name

        def fields; @@fields; end
      end

      # пройдёмся по списку полей таблицы и создадим методы getter и setter для них
      @@db.list_fields(table_name).each do |field|
        # добавляем getter и setter
        klass.send :attr_accessor, field

        # добавляем имя поля в список полей
        klass.module_eval { @@fields << field }
      end
      #p klass.new.fields
      @generated_classes << klass
      #p klass.new.fields

    end
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
