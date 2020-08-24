class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text :description,null: false
      t.integer :price,null: false
      t.references :user,null: false, foreign_key: true
      t.integer :category_id  ,null: false
      t.integer :condition_id ,null: false
      t.integer :shipping_fee_person_id,null: false
      t.integer :date_ish_id,null: false
      t.integer :region_id,null: false
      t.timestamps
    end
  end
end
