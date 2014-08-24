class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :surname
      t.string :oblakan_uid
      t.string :role

      t.timestamps
    end
  end
end
