require './db'


class MiniActiveRecord
  # сохраним список сгенерированных классов в переменной класса
  class << self; attr_reader :generated_classes, :table_name; end
  @generated_classes = []
  @@table_name = ""

  def initialize(attributes = nil)
    if !@@table_name.empty?
      @@db.list_fields(@@table_name).each do |field|
      # добавляем getter и setter
      self.send :attr_accessor, field

      # добавляем имя поля в список полей
      klass.module_eval { @@fields << field }
      end
    end
    if attributes
      attributes.each_pair do |key, value|
        instance_variable_set('@' + key, value)
      end
    end
  end

  def self.connect(params)
    @@db = DataBase params['provider'], params
    @@db.init_connection

  end
  # получаем все строки
  def self.all
      result = @@db.query_builder.select(" * ").from(self.table_name).run.result
      found = []
      result.each do |attributes|
        found << new(attributes)
      end
      found
    end
  # получаем строку таблицы по идентификатору
  def self.get(id)
    result = @@db.query_builder.select(" * ").from(self.table_name).where(" `id` = #{id}").run.result
    attributes = result.first
    new(attributes) if attributes
  end
  def self.get_by(key, value)
    result = @@db.query_builder.select(" * ").from(self.table_name).where(" `#{key}` = #{value}").run.result
    found = []
    result.each do |attributes|
      found << new(attributes)
    end
    found
  end

end

class Figure < MiniActiveRecord
  @table_name = "figures"
end
class Formula < MiniActiveRecord
  @table_name = "formulas"
end
class ParameterSet < MiniActiveRecord
  @table_name = "parameter_sets"
end
class Square < MiniActiveRecord
  @table_name = "square"
end
class Error < MiniActiveRecord
  @table_name = "errors"
end
