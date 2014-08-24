# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  is_final   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Status < ActiveRecord::Base
  has_many :reports

  def to_s
    self.name
  end
end
