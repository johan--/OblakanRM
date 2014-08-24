class AddUserGender < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :is_male, default: true
    end
  end
end
