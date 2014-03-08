class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|

      t.timestamps
    end
  end
end
