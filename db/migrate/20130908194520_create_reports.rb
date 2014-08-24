class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.text :description
      t.integer :user_id, index: true
      t.integer :status_id, index: true
      t.string :address
      t.integer :start_photo_id, index: true
      t.integer :end_photo_id, index: true
      t.boolean :is_deleted, default: false, index: true
      t.point :location, geographic: true

      t.timestamps
    end

    add_index :reports, :location, spatial: true
  end
end
