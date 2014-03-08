class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string    :zipcode
      t.integer   :radius
      t.integer   :location_x
      t.integer   :location_y
      t.timestamps 
    end
  end
end
