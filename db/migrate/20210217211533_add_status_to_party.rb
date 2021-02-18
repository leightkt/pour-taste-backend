class AddStatusToParty < ActiveRecord::Migration[6.1]
  def change
    add_column :parties, :party_open, :boolean
  end
end
