class CreateItemStates < ActiveRecord::Migration
  def change
    create_table :item_states do |t|
      t.string    :desc
      t.integer   :value

      t.timestamps
    end
  end
end
