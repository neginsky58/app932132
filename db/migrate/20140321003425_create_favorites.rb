class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      
      t.integer   :user_id

      t.integer   :category_id
      t.integer   :person_type_id
      t.integer   :size_id
      t.string    :search_word
      t.timestamps
    end
  end
end
