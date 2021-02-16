class RemoveUserFromParty < ActiveRecord::Migration[6.1]
  def change
    remove_column :parties, :user_id
  end
end
