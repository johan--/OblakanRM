# == Schema Information
#
# Table name: subscribers
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  subscribe_type :string(255)
#  subscribe_id   :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require "#{Rails.root}/lib/validators/blacklist_validator"

class Subscriber < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribe, polymorphic: true
  validates :user_id, uniqueness: { scope: [:subscribe_type, :subscribe_id] },
            presence: true, blacklist: true
  validates :code, presence: true, if: Proc.new { |subscriber| subscriber.user.is_guest }

  before_validation :set_code, if: Proc.new { |subscriber| subscriber.user.is_guest }
  before_create  :increment_counter
  before_destroy :decrement_counter

  scope :by_user, -> user_id { where(user_id: user_id) }
  scope :by_sid, -> subscribe_id { where(subscribe_id: subscribe_id) }
  scope :by_stype, -> subscribe_type { where(subscribe_type: subscribe_type) }

  private

    def set_code
      unless self.code.present?
        self.code = SecureRandom.urlsafe_base64(nil, false)
      end
    end

    def increment_counter
      self.subscribe_type.constantize.increment_counter("#{self.class.to_s.downcase.pluralize}_count", self.subscribe_id)
    end

    def decrement_counter
      self.subscribe_type.constantize.decrement_counter("#{self.class.to_s.downcase.pluralize}_count", self.subscribe_id)
    end
end