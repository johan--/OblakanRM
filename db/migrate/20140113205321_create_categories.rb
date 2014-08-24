class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :title
      t.text :description, null: true
      t.string :icon
      t.integer :parent_id

      t.timestamps
    end
    add_index :categories, :parent_id
    Category.create_translation_table! title: :string, description: { type: :string, null: true }

    change_table :reports do |t|
      t.integer :category_id, null: true
    end
    add_index :reports, :category_id
  end

  def down
    drop_table :categories
    remove_column :reports, :category_id
    Category.drop_translation_table!
  end
end
