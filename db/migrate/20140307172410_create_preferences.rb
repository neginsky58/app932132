class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer   :item_id
      t.integer   :clothing_id
      t.integer   :size_id
      t.integer   :person_type_id      
      t.timestamps
    end
  end
end
