class AddClientVisibilityToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :client_visibility, :boolean
  end
end
