class CreatePastAttribute < ActiveRecord::Migration
  def change
    create_table :past_attributes do |t|
      t.timestamps
      t.string :value, null:false
      t.string :key, null:false
      t.string :tuple_type, null:false
      t.integer :tuple_id, null:false
      t.index [:value, :key, :tuple_type, :tuple_id], unique:true, name: "past_attributes_main_index"
    end
  end
end
