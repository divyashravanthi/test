class AddPublishedToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :published, :boolean, :default => false
  end
end
