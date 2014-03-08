class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|

      t.timestamps
    end
  end
end
