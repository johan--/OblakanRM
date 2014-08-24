# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string(255)
#  first_name           :string(255)
#  last_name            :string(255)
#  surname              :string(255)
#  oblakan_uid          :string(255)
#  role                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  email                :string(255)      default(""), not null
#  sign_in_count        :integer          default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  authentication_token :string(255)
#  oblakan_access_token :string(255)
#  avatar               :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable
  validates :email, format: { :with => /.*@.*/ }

  has_many :reports

  def self.find_oblakan_oauth(oauth_data)
    User.where('oblakan_uid = ? OR email = ?', oauth_data.uid, oauth_data.info.email).first_or_create.tap do |user|
      user.oblakan_uid = oauth_data.uid
      user.email = oauth_data.info.email
      user.username = oauth_data.info.username
      user.is_male = oauth_data.info.is_male
      user.avatar = oauth_data.info.avatar
    end
  end

  def update_oblakan_credentials(oauth_data)
    self.oblakan_access_token = oauth_data.credentials.token
    self.email = oauth_data.info.email
    self.username = oauth_data.info.username
    self.is_male = oauth_data.info.is_male
    self.avatar = oauth_data.info.avatar.avatar.thumb.url
  end

  def to_s
    self.username
  end

  def avatar_url
    "http://id.oblakan.ru#{self.avatar}" if self.avatar.present?
  end

  def is_guest
    !self.oblakan_uid.present?
  end

  def is_regular
    !self.is_guest
  end

  def is_admin
    self.role == 'admin'
  end

  def is_staff
    self.role == 'staff'
  end
end
