class AddReadFieldToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read, :boolean
  end
end
