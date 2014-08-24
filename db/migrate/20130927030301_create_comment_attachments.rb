class CreateCommentAttachments < ActiveRecord::Migration
  def change
    create_table :comment_attachments do |t|
      t.belongs_to :photo, index: true
      t.belongs_to :comment, index: true

      t.timestamps
    end
  end
end
