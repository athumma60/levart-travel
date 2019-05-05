class AddSoftDeleteFieldToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :is_deleted, :boolean
    add_column :reservations, :deleted_time, :timestamp
  end
end
