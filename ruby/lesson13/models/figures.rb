require './mini_ar'
class Figure < MiniActiveRecord

  def fields; @@fields; end
  def self.table_name; 'figures' ; end
  attr_accessor :id, :name 
  @@fields = ["id", "name"]
end
