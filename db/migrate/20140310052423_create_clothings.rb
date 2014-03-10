class CreateClothings < ActiveRecord::Migration
  def change
    create_table :clothings do |t|

      t.string :name
      t.string :desc

      t.timestamps
    end
  end
end
