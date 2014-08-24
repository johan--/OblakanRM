class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :uid
      t.string :file
      t.string :entity_type
      t.integer :entity_id

      t.timestamps
    end

    add_index :photos, :entity_id
    add_index :photos, :uid
  end
end