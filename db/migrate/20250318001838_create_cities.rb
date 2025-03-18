class CreateCities < ActiveRecord::Migration[7.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.boolean :is_capital
      t.integer :population
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
