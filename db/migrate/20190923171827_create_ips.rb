class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.references :whitelist, index: true, foreign_key: true
      t.string :address, null: false

      t.timestamps null: false
    end
  end
end
