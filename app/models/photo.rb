# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  uid         :string(255)
#  file        :string(255)
#  entity_type :string(255)
#  entity_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Photo < ActiveRecord::Base
  include UIDString
  mount_uploader :file, PhotoUploader
  belongs_to :entity, polymorphic: true
  has_one :report, foreign_key: 'start_photo_id', dependent: :nullify

  before_create  :increment_counter
  before_destroy :decrement_counter

  def original_url
    self.file.url
  end

  def medium_thumb
    self.file.url(:medium_thumb)
  end

  def small_thumb
    self.file.url(:small_thumb)
  end

  private

    def increment_counter
      self.entity_type.constantize.increment_counter("#{self.class.to_s.downcase.pluralize}_count", self.entity_id)
    end

    def decrement_counter
      self.entity_type.constantize.decrement_counter("#{self.class.to_s.downcase.pluralize}_count", self.entity_id)
    end
end
