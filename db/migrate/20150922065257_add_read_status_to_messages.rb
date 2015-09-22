class AddReadStatusToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read_status, :boolean, :default => false
  end
end
