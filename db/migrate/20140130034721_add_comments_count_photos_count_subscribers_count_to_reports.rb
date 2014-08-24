class AddCommentsCountPhotosCountSubscribersCountToReports < ActiveRecord::Migration

  def self.up

    add_column :reports, :comments_count, :integer, :null => false, :default => 0

    add_column :reports, :photos_count, :integer, :null => false, :default => 0

    add_column :reports, :subscribers_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :reports, :comments_count

    remove_column :reports, :photos_count

    remove_column :reports, :subscribers_count

  end

end
