class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.boolean :is_final, default: false

      t.timestamps
    end
  end
end
