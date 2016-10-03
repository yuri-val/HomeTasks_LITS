require './mini_ar'
class Figure < MiniActiveRecord
  @@table_name = 'figures'

  def fields; @@fields; end
  attr_accessor :id, :name 
  @@fields = ["id", "name"]
end
