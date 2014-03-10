class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string    :name
      t.string    :desc
      t.integer   :value
      t.timestamps
    end
  end
end
