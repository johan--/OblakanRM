class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :user_id, index: true
      t.string :code
      t.string :subscribe_type
      t.integer :subscribe_id, index: true

      t.timestamps
    end
  end
end