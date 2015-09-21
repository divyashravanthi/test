class AddTitleToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :title, :text
  end
end
