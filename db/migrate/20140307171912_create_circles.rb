class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string    :name
      t.string    :zipcode
      t.string    :city
      t.string    :state
      t.boolean   :status
      t.timestamps 
    end
  end
end
