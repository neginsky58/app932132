class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      
      t.string  :username
      t.string  :password
      t.integer :permission

      t.timestamps
    end
  end
end
