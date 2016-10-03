require './mini_ar'
class Square < MiniActiveRecord
  @@table_name = 'squares'

  def fields; @@fields; end
  attr_accessor :id, :figure_id, :formula_id, :parameter_set_id, :square 
  @@fields = ["id", "figure_id", "formula_id", "parameter_set_id", "square"]
end
