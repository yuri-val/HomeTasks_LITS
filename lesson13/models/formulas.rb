require './mini_ar'
class Formula < MiniActiveRecord
  @@table_name = 'formulas'

  def fields; @@fields; end
  attr_accessor :id, :figure_id, :name, :formula 
  @@fields = ["id", "figure_id", "name", "formula"]
end
