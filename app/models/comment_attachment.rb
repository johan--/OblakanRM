# == Schema Information
#
# Table name: comment_attachments
#
#  id         :integer          not null, primary key
#  photo_id   :integer
#  comment_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class CommentAttachment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :comment
end
