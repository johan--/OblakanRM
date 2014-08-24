class Category < ActiveRecord::Base
  translates :title, :description
  has_many :reports

  def to_s
    self.title
  end
end
