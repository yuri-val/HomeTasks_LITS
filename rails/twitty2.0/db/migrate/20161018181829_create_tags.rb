class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true
      t.integer :parent_id, :null => true, :index => true
      t.integer :children_count, :null => false, :default => 0

      t.timestamps
    end
  end
end
