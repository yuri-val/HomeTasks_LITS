require './mini_ar'
class Error < MiniActiveRecord
  @@table_name = 'errors'

  def fields; @@fields; end
  attr_accessor :id, :figure_id, :formula_id, :parameter_set_id, :err_code, :err_msg 
  @@fields = ["id", "figure_id", "formula_id", "parameter_set_id", "err_code", "err_msg"]
end
