# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  is_deleted       :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  include PublicActivity::Common

  before_create  :increment_counter
  before_destroy :decrement_counter

  validates :content, :commentable_id, :commentable_type, presence: true

  private

    def increment_counter
      self.commentable_type.constantize.increment_counter("#{self.class.to_s.downcase.pluralize}_count", self.commentable_id )
    end

    def decrement_counter
      self.commentable_type.constantize.decrement_counter("#{self.class.to_s.downcase.pluralize}_count", self.commentable_id)
    end
end
