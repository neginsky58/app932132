class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string  :name
      t.string  :desc
      t.timestamps
    end
  end
end
