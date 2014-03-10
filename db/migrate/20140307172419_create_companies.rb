class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string    :facebook_id
      t.string    :email
      t.integer   :circle_id
      t.integer   :company_status_id
      t.string    :name
      t.string    :desc
      t.string    :url
      t.string    :hours
      t.string    :phone
      t.integer   :rating
      t.boolean   :is_active
      t.timestamps
    end
  end
end
