class AddBidUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :bid_user_id, :integer        
  end
end
