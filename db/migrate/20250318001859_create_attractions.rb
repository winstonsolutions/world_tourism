class CreateAttractions < ActiveRecord::Migration[7.2]
  def change
    create_table :attractions do |t|
      t.string :name
      t.text :description
      t.decimal :rating
      t.decimal :entrance_fee
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
