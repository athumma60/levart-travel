class AddSoftDeleteFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_deleted, :boolean
    add_column :users, :deleted_time, :timestamp
  end
end
