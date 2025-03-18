class CreateCountries < ActiveRecord::Migration[7.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :continent
      t.string :currency
      t.string :language

      t.timestamps
    end
  end
end
