class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer   :item_id
      t.integer   :from_user
      t.text      :text
      t.timestamps
    end
  end
end
