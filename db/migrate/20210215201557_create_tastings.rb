class CreateTastings < ActiveRecord::Migration[6.1]
  def change
    create_table :tastings do |t|
      t.references :wine, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :party, null: false, foreign_key: true
      t.string :notes
      t.string :letter
      t.integer :rating

      t.timestamps
    end
  end
end
