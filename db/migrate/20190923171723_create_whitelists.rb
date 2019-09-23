class CreateWhitelists < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.references :company, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
