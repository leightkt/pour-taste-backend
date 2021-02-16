class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :host
      t.references :party, null: false, foreign_key: true

      t.timestamps
    end
  end
end
