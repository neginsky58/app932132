class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|

      t.integer :value
      t.string  :name
      t.string  :desc      
      t.timestamps
    end
  end
end
