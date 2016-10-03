require './mini_ar'
class Square < MiniActiveRecord

  def fields; @@fields; end
  def self.table_name; 'squares' ; end
  attr_accessor :id, :figure_id, :formula_id, :parameter_set_id, :square 
  @@fields = ["id", "figure_id", "formula_id", "parameter_set_id", "square"]
end
