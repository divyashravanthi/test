class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :request, index: true
      t.text :raw_text, null: true
      t.integer :receiver_id
      t.timestamps null: false
    end
    add_foreign_key :messages, :requests
  end
end
