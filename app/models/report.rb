# == Schema Information
#
# Table name: reports
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  description    :text
#  user_id        :integer
#  status_id      :integer
#  address        :string(255)
#  start_photo_id :integer
#  end_photo_id   :integer
#  is_deleted     :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :status
  belongs_to :category
  belongs_to :start_photo, class_name: 'Photo'
  has_many :photos, :as => :entity, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :subscribers, :as => :subscribe, dependent: :destroy
  paginates_per 10

  attr_accessor(:longitude, :latitude)

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  default_scope -> { order('created_at desc') }
  scope :normal_scope, -> { where(is_deleted: false) }

  validates :title, :status_id, :user_id, presence: true
  validates :description, length: { maximum: 5000 }

  def self.map_scope
    self.joins(:status)
        .where('statuses.is_final = ? OR (statuses.is_final = ? AND closed_at > ?)', false, true, 1.month.ago)
  end

  def near(distance = 1000.0, limit = 10)
    raise 'Location should be not empty' unless self.location.present?
    near = Report.where("ST_DWithin(location, ST_GeographyFromText('SRID=4326;POINT(#{self.location.longitude} #{self.location.latitude})'), #{distance})").limit(limit).to_a
    near.delete(self)
    near.delete_if { |x| x.is_deleted }
    near
  end

  def distance(location)
    Report.dist
  end

  def is_subscribed? (user)
    result = false

    if user
      self.subscribers.each do |subscriber|
        if subscriber.user_id == user.id
          result = true
          break
        end
      end
    end

    result
  end

  def photos_count_fix
    self.update_column(:photos_count, self.photos.count)
  end

  def comments_count_fix
    self.update_column(:comments_count, self.comments.count)
  end

  def subscribers_count_fix
    self.update_column(:subscribers_count, self.subscribers.count)
  end

  def activities
    PublicActivity::Activity.order('created_at desc')
  end

  def longitude
    self.location.longitude if self.location
  end

  def latitude
    self.location.latitude  if self.location
  end
end
