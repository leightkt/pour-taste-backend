class CreateParties < ActiveRecord::Migration[6.1]
  def change
    create_table :parties do |t|
      t.string :date
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :time

      t.timestamps
    end
  end
end
