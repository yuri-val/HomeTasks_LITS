class ChangeContent < ActiveRecord::Migration[5.0]
  def change
  	change_column :twits, :content, :string, :null => false
  end
end
