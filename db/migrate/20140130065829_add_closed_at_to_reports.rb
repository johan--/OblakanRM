class AddClosedAtToReports < ActiveRecord::Migration
  def up
    add_column :reports, :closed_at, :datetime, null: true
  end

  def down
    remove_column :reports, :closed_at
  end
end
