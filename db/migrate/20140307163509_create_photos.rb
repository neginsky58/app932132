class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer     :item_id      
      t.attachment  :file

      
      t.timestamps
    end
  end
end
