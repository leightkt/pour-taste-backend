class CreateWines < ActiveRecord::Migration[6.1]
  def change
    create_table :wines do |t|
      t.string :brand
      t.string :variety
      t.string :name
      t.integer :year
      t.string :wine_type

      t.timestamps
    end
  end
end
