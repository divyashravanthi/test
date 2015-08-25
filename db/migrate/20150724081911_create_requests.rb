class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to :user, index: true
      t.integer :receiver_id

      t.timestamps null: false
    end
    add_foreign_key :requests, :users
  end
end
