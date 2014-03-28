class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :item_id
      t.integer :user_id
      t.decimal :price, :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
