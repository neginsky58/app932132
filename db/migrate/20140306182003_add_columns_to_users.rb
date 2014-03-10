class AddColumnsToUsers < ActiveRecord::Migration
  def change

    add_column :users, :provider, :string
    add_column :users, :facebook_id, :string
    add_column :users, :name, :string
    add_column :users, :circle_id, :integer
    add_column :users, :preference_id, :integer
    add_column :users, :max_pickupradius, :integer
    add_column :users, :max_price, :decimal, :precision => 10, :scale => 2
    add_column :users, :min_price, :decimal, :precision => 10, :scale => 2
    add_column :users, :min_condition, :integer
    add_column :users, :banned_reason, :string
    add_column :users, :is_locked, :boolean
    
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime

    add_column :users, :user_group_id, :integer, :default => 4

  end
end
