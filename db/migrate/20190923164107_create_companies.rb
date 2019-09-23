class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name,                         limit: 200,                 null: false
      t.integer :responsible_id,              limit: 8
      t.boolean :has_pip_features,                        default: false, null: false
      t.string :customers_type,               limit: 20,  default: "regular"
      t.string :timezone,                     limit: 100, default: "UTC"
      t.integer :parcel_index_report_view_id

      t.timestamps null: false
    end
  end
end

