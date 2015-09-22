class AddExpiredToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :is_expired, :boolean, :default => false
  end
end
