class CreateUserPlans < ActiveRecord::Migration
  def change
    create_table :user_plans do |t|

      t.string  :name
      t.string  :desc
      
      t.timestamps
    end
  end
end
