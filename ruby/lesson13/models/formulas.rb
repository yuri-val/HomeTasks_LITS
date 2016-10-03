require './mini_ar'
class Formula < MiniActiveRecord

  def fields; @@fields; end
  def self.table_name; 'formulas' ; end
  attr_accessor :id, :figure_id, :name, :formula 
  @@fields = ["id", "figure_id", "name", "formula"]
end
