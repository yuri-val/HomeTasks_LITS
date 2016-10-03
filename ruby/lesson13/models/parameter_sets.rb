require './mini_ar'
class ParameterSet < MiniActiveRecord

  def fields; @@fields; end
  def self.table_name; 'parameter_sets' ; end
  attr_accessor :id, :formula_id, :p1, :p2, :p3, :p4, :p5 
  @@fields = ["id", "formula_id", "p1", "p2", "p3", "p4", "p5"]
end
