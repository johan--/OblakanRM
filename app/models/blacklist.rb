# == Schema Information
#
# Table name: blacklists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Blacklist < ActiveRecord::Base
  belongs_to :user

  validates :user_id, uniqueness: true
end
